#!/usr/bin/env bash
#
# Bootstrap these dotfiles on a fresh Mac.
#
#   curl -fsSL https://raw.githubusercontent.com/PierrotAWB/dotfiles/MacOS/install.sh | bash
#
# Installs Homebrew + the tools the configs actually reference, clones the repo,
# symlinks zsh / nvim / lf into place, and bootstraps packer.nvim.
#
# Safe to re-run. Anything it would clobber is moved to <path>.bak-<timestamp>.
#
# Options (after `| bash -s --`):
#   --no-deps       skip all brew installs
#   --no-extras     core tools only, skip lf preview handlers
#   --no-nvim-sync  skip the headless PackerSync
#   --lfub          also install lfub (removed from this branch; lfcd uses lf)
#   --ssh           clone over SSH instead of HTTPS
#   -h, --help      this message
#
# Env overrides: DOTFILES_DIR, DOTFILES_REPO, DOTFILES_BRANCH

set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/PierrotAWB/dotfiles.git}"
DOTFILES_SSH_REPO="git@github.com:PierrotAWB/dotfiles.git"
DOTFILES_BRANCH="${DOTFILES_BRANCH:-MacOS}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.local/share/dotfiles}"

LFUB_URL="https://raw.githubusercontent.com/PierrotAWB/scripts/master/lfub"
FSYH_REPO="https://github.com/zdharma-continuum/fast-syntax-highlighting.git"

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

DO_DEPS=1
DO_EXTRAS=1
DO_NVIM_SYNC=1
DO_LFUB=0
USE_SSH=0
STAMP="$(date +%Y%m%d%H%M%S)"
BREW_PREFIX=""

# Referenced by .zshrc, aliasrc, lfrc, and the nvim config.
#   coreutils   -> gls (aliasrc), gstat/gsha256sum (lf scope)
#   util-linux  -> setsid (lfrc); .zshenv already puts it on PATH
#   moreutils   -> vidir (lfrc bulkrename)
#   bat, fd, rg -> fzf-lua previews and the grep alias
#   node@22/nvm -> both are on PATH in .zshrc; mason needs a node
BREW_CORE=(
	git neovim lf fzf ripgrep fd bat
	coreutils util-linux moreutils
	node@22 nvm uv pnpm python
)

# lf's scope previewer shells out to these; each is optional.
BREW_EXTRAS=(mediainfo ffmpegthumbnailer poppler lynx atool gnupg mpv)

# ---------------------------------------------------------------- output ----

if [ -t 1 ]; then
	C_BOLD=$'\033[1m'; C_BLUE=$'\033[34m'; C_YELLOW=$'\033[33m'
	C_RED=$'\033[31m'; C_OFF=$'\033[0m'
else
	C_BOLD=""; C_BLUE=""; C_YELLOW=""; C_RED=""; C_OFF=""
fi

step() { printf '%s==>%s %s%s%s\n' "$C_BLUE" "$C_OFF" "$C_BOLD" "$*" "$C_OFF"; }
info() { printf '    %s\n' "$*"; }
warn() { printf '%swarn:%s %s\n' "$C_YELLOW" "$C_OFF" "$*" >&2; }
die()  { printf '%serror:%s %s\n' "$C_RED" "$C_OFF" "$*" >&2; exit 1; }
have() { command -v "$1" >/dev/null 2>&1; }
tilde() { printf '%s' "${1/#$HOME/~}"; }

usage() {
	if [ -r "${BASH_SOURCE[0]:-$0}" ]; then
		awk 'NR>2 { if ($0 !~ /^#/) exit; sub(/^# ?/, ""); print }' "${BASH_SOURCE[0]:-$0}"
	else
		echo "usage: install.sh [--no-deps] [--no-extras] [--no-nvim-sync] [--lfub] [--ssh]"
	fi
}

# ---------------------------------------------------------------- deps ----

preflight() {
	[ "$(uname -s)" = Darwin ] ||
		die "this branch is macOS-only; use the master branch on Linux"

	# nvim-treesitter compiles parsers, so the CLT has to be there.
	if ! xcode-select -p >/dev/null 2>&1; then
		warn "Xcode command line tools missing; treesitter parsers will not build"
		info "run: xcode-select --install"
	fi
}

install_brew() {
	if have brew; then
		BREW_PREFIX="$(brew --prefix)"
		return
	fi
	step "Installing Homebrew"
	NONINTERACTIVE=1 /bin/bash -c \
		"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	for p in /opt/homebrew /usr/local; do
		[ -x "$p/bin/brew" ] && { eval "$("$p/bin/brew" shellenv)"; break; }
	done
	have brew || die "Homebrew install did not put brew on PATH"
	BREW_PREFIX="$(brew --prefix)"
}

# One `brew install` per formula: a single bad name shouldn't sink the batch.
brew_install() {
	local f
	for f in "$@"; do
		if brew list --versions "$f" >/dev/null 2>&1; then
			info "ok       $f"
		elif brew install --quiet "$f" >/dev/null 2>&1; then
			info "install  $f"
		else
			warn "brew install $f failed; skipped"
		fi
	done
}

install_deps() {
	install_brew

	step "Installing core tools"
	brew_install "${BREW_CORE[@]}"

	if [ "$DO_EXTRAS" -eq 1 ]; then
		step "Installing lf preview handlers"
		brew_install "${BREW_EXTRAS[@]}"
	else
		step "Skipping extras (--no-extras)"
	fi

	install_pynvim
}

# .zshrc sources ~/.fzf.zsh, which only exists if fzf's own installer ran.
install_fzf_keybindings() {
	[ -f "$HOME/.fzf.zsh" ] && { info "ok       ~/.fzf.zsh"; return 0; }

	local script="${BREW_PREFIX:-/opt/homebrew}/opt/fzf/install"
	[ -x "$script" ] || { warn "fzf installer not found; ^R/^T keybindings will be off"; return 0; }

	step "Generating ~/.fzf.zsh"
	"$script" --key-bindings --completion --no-update-rc --no-bash --no-fish >/dev/null 2>&1 ||
		warn "fzf installer failed"
}

# UltiSnips needs python3 support in nvim.
install_pynvim() {
	python3 -c 'import pynvim' >/dev/null 2>&1 && { info "ok       pynvim"; return 0; }
	have python3 || { warn "python3 missing; UltiSnips will not work"; return 0; }
	step "Installing pynvim (UltiSnips)"
	python3 -m pip install --user --quiet --upgrade pynvim 2>/dev/null ||
		python3 -m pip install --user --quiet --break-system-packages --upgrade pynvim 2>/dev/null ||
		warn "pip install pynvim failed; UltiSnips will not work"
}

# ---------------------------------------------------------------- repo ----

# When run from a checkout, use it. When piped from curl, clone.
locate_repo() {
	local src="${BASH_SOURCE[0]:-}" here=""
	if [ -n "$src" ] && [ -f "$src" ]; then
		here="$(cd "$(dirname "$src")" && pwd)"
	fi

	if [ -n "$here" ] && [ -f "$here/.zshenv" ] && [ -d "$here/.config/zsh" ]; then
		DOTFILES_DIR="$here"
		step "Using existing checkout: $(tilde "$DOTFILES_DIR")"
		return
	fi

	[ "$USE_SSH" -eq 1 ] && DOTFILES_REPO="$DOTFILES_SSH_REPO"

	if [ -d "$DOTFILES_DIR/.git" ]; then
		step "Updating $(tilde "$DOTFILES_DIR")"
		git -C "$DOTFILES_DIR" fetch --quiet origin "$DOTFILES_BRANCH"
		git -C "$DOTFILES_DIR" checkout --quiet "$DOTFILES_BRANCH"
		git -C "$DOTFILES_DIR" merge --ff-only --quiet "origin/$DOTFILES_BRANCH" ||
			warn "could not fast-forward $DOTFILES_BRANCH; leaving as-is"
	else
		step "Cloning $DOTFILES_REPO ($DOTFILES_BRANCH)"
		have git || die "git is required"
		mkdir -p "$(dirname "$DOTFILES_DIR")"
		git clone --quiet --branch "$DOTFILES_BRANCH" "$DOTFILES_REPO" "$DOTFILES_DIR"
	fi
}

# ---------------------------------------------------------------- linking ----

# link <source-in-repo> <destination>
link() {
	local src="$1" dst="$2"

	[ -e "$src" ] || { warn "missing in repo: $src"; return 0; }

	if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
		info "ok       $(tilde "$dst")"
		return 0
	fi

	mkdir -p "$(dirname "$dst")"

	if [ -e "$dst" ] || [ -L "$dst" ]; then
		mv "$dst" "$dst.bak-$STAMP"
		info "backup   $(tilde "$dst") -> $(tilde "$dst").bak-$STAMP"
	fi

	ln -s "$src" "$dst"
	info "link     $(tilde "$dst") -> $(tilde "$src")"
}

link_config() {
	step "Linking config"

	# .zshenv must live in $HOME; it sources .config/env, which sets ZDOTDIR
	# and then sources $ZDOTDIR/.zshrc.
	link "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
	link "$DOTFILES_DIR/.config/env" "$XDG_CONFIG_HOME/env"
	link "$DOTFILES_DIR/.config/zsh" "$XDG_CONFIG_HOME/zsh"
	link "$DOTFILES_DIR/.config/nvim" "$XDG_CONFIG_HOME/nvim"
	link "$DOTFILES_DIR/.config/lf" "$XDG_CONFIG_HOME/lf"
}

make_dirs() {
	step "Creating runtime directories"
	# HISTFILE is $XDG_DATA_HOME/zsh/history in .config/env, then reassigned to
	# $XDG_CONFIG_HOME/zsh/history in .zshrc; both parents must exist.
	mkdir -p \
		"$XDG_DATA_HOME/zsh" \
		"$XDG_CACHE_HOME/zsh" \
		"$XDG_CACHE_HOME/lf" \
		"$XDG_DATA_HOME/nvim/swap" \
		"$XDG_DATA_HOME/nvim/undo" \
		"$HOME/.local/bin"
	info "ok"
}

install_zsh_plugins() {
	local dir="$XDG_DATA_HOME/zsh/plugins/fast-syntax-highlighting"

	if [ -d "$dir/.git" ]; then
		info "ok       fast-syntax-highlighting"
		return 0
	fi

	step "Installing fast-syntax-highlighting"
	mkdir -p "$(dirname "$dir")"
	git clone --quiet --depth 1 "$FSYH_REPO" "$dir" ||
		warn "clone failed; syntax highlighting will be off"
}

# This branch dropped lfub (lfcd calls lf directly), so this is opt-in only.
install_lfub() {
	[ "$DO_LFUB" -eq 1 ] || return 0
	local dst="$HOME/.local/bin/lfub"

	step "Installing lfub"
	if curl -fsSL "$LFUB_URL" -o "$dst.tmp" && head -1 "$dst.tmp" | grep -q '^#!'; then
		mv "$dst.tmp" "$dst"
		chmod +x "$dst"
		info "ok       $(tilde "$dst")"
		have ueberzug ||
			warn "lfub calls ueberzug, which is not installed; it will fail off-SSH"
	else
		rm -f "$dst.tmp"
		warn "could not download lfub"
	fi
}

# ---------------------------------------------------------------- neovim ----

bootstrap_nvim() {
	local packer="$XDG_DATA_HOME/nvim/site/pack/packer/start/packer.nvim"

	if [ -d "$packer/.git" ]; then
		info "ok       packer.nvim"
	else
		step "Installing packer.nvim"
		mkdir -p "$(dirname "$packer")"
		git clone --quiet --depth 1 \
			https://github.com/wbthomason/packer.nvim "$packer" ||
			{ warn "packer clone failed; skipping plugin sync"; return 0; }
	fi

	if [ "$DO_NVIM_SYNC" -eq 0 ]; then
		info "skipping PackerSync (--no-nvim-sync); run :PackerSync in nvim"
		return 0
	fi
	have nvim || { warn "nvim not installed; skipping plugin sync"; return 0; }

	step "Syncing nvim plugins (this takes a minute)"
	nvim --headless \
		-c 'autocmd User PackerComplete quitall' \
		-c 'PackerSync' >/dev/null 2>&1 ||
		warn "PackerSync reported errors; open nvim and run :PackerStatus"
	info "ok"
}

# ---------------------------------------------------------------- finish ----

report() {
	step "Done"
	echo
	info "dotfiles: $(tilde "$DOTFILES_DIR")"
	echo
	info "Not handled here (install by hand if you want them):"
	info "  claude, cursor, daytona, mutagen, wt  - referenced by aliasrc"
	info "  MacTeX                                - for the sty alias and vimtex"
	echo

	if [ "$(basename "${SHELL:-}")" != zsh ]; then
		warn "login shell is ${SHELL:-unknown}, not zsh. Switch with: chsh -s /bin/zsh"
	fi

	info "Start a new shell (or: exec zsh) to pick everything up."
}

# ---------------------------------------------------------------- main ----

main() {
	while [ $# -gt 0 ]; do
		case "$1" in
		--no-deps) DO_DEPS=0 ;;
		--no-extras) DO_EXTRAS=0 ;;
		--no-nvim-sync) DO_NVIM_SYNC=0 ;;
		--lfub) DO_LFUB=1 ;;
		--ssh) USE_SSH=1 ;;
		-h|--help) usage; exit 0 ;;
		*) die "unknown option: $1 (try --help)" ;;
		esac
		shift
	done

	preflight

	if [ "$DO_DEPS" -eq 1 ]; then
		install_deps
	else
		step "Skipping dependencies (--no-deps)"
		have brew && BREW_PREFIX="$(brew --prefix)"
	fi

	locate_repo
	make_dirs
	link_config
	install_zsh_plugins
	install_fzf_keybindings
	install_lfub
	bootstrap_nvim
	report
}

main "$@"
