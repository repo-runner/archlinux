#!/bin/bash
set -euxo pipefail

# Packages required to build the image
pkg_build=(
	jq
)

# Packages kept for the final image
pkg_img=(
	ca-certificates
	curl
	docker
	git
	make
)

# Install required packages
pacman -Syyu --noconfirm
pacman -S --noconfirm "${pkg_build[@]}" "${pkg_img[@]}"

function get_asset_url() {
	curl -sSfL "https://api.github.com/repos/${1}/releases/latest" |
		jq -r '.assets | .[] | .browser_download_url' |
		grep -E 'linux.*amd64.tar.gz'
}

# Download latest release of inner-runner
curl -sSfL "$(get_asset_url repo-runner/repo-runner | grep inner-runner)" | tar -xzf - -C /usr/local/bin
mv /usr/local/bin/inner-runner* /usr/local/bin/inner-runner

# Purge build-packages
pacman -Rs --noconfirm "${pkg_build[@]}"
