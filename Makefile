# Update dependencies
setup			:; make init-modules; make install-deps
init-modules	:; git submodule update --init --recursive
install-deps	:; pnpm install --frozen-lockfile
update-deps		:; pnpm install
