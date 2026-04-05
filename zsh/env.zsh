export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Binary mirror
# === NPM BINARY CHINA ===
# https://github.com/cnpm/binary-mirror-config/blob/master/package.json#L53
export NODEJS_ORG_MIRROR="https://cdn.npmmirror.com/binaries/node"
export NVM_NODEJS_ORG_MIRROR="https://cdn.npmmirror.com/binaries/node"
export PHANTOMJS_CDNURL="https://cdn.npmmirror.com/binaries/phantomjs"
export CHROMEDRIVER_CDNURL="https://cdn.npmmirror.com/binaries/chromedriver"
export OPERADRIVER_CDNURL="https://cdn.npmmirror.com/binaries/operadriver"
export ELECTRON_MIRROR="https://cdn.npmmirror.com/binaries/electron/"
export ELECTRON_BUILDER_BINARIES_MIRROR="https://cdn.npmmirror.com/binaries/electron-builder-binaries/"
export SASS_BINARY_SITE="https://cdn.npmmirror.com/binaries/node-sass"
export SWC_BINARY_SITE="https://cdn.npmmirror.com/binaries/node-swc"
export NWJS_URLBASE="https://cdn.npmmirror.com/binaries/nwjs/v"
export PUPPETEER_DOWNLOAD_HOST="https://cdn.npmmirror.com/binaries"
export SENTRYCLI_CDNURL="https://cdn.npmmirror.com/binaries/sentry-cli"
export SAUCECTL_INSTALL_BINARY_MIRROR="https://cdn.npmmirror.com/binaries/saucectl"
# For Cypress >=10.6.0, https://docs.cypress.io/guides/references/changelog#10-6-0
export CYPRESS_DOWNLOAD_PATH_TEMPLATE='https://cdn.npmmirror.com/binaries/cypress/${version}/${platform}-${arch}/cypress.zip'

# Cargo-installed binaries
if [ -d "$HOME/.cargo/bin" ]; then
  case ":$PATH:" in
    *":$HOME/.cargo/bin:"*) ;;
    *) export PATH="$HOME/.cargo/bin:$PATH" ;;
  esac
fi
