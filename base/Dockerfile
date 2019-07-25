FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
MAINTAINER daquexian

# COPY setup_base.sh .
# RUN bash setup_base.sh

# Uncomment it if you are in China
RUN sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# For ppa
RUN apt -o Acquire::http::proxy=false update
RUN apt -o Acquire::http::proxy=false install -y apt-utils software-properties-common && \
    apt clean

# Install aria2
RUN apt -o Acquire::http::proxy=false install -y aria2 && apt clean

# Add neovim ppa
RUN add-apt-repository -y ppa:neovim-ppa/stable
# && add-apt-repository -y ppa:git-core/ppa && aria2c https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh && bash script.deb.sh && rm script.deb.sh

# Add common tools available in apt repository. We choose not to support python2
RUN apt -o Acquire::http::proxy=false update && apt -o Acquire::http::proxy=false install -y man telnet locales pkg-config inetutils-ping net-tools git zsh thefuck mc sed ack-grep ranger htop silversearcher-ag python3 python3-dev neovim build-essential autoconf automake libtool make gcc g++ curl wget tar libevent-dev libncurses-dev unzip openjdk-8-jdk colordiff mlocate iftop libpulse-dev libv4l-dev python3-venv libcurl4-openssl-dev gdb tzdata && apt clean

RUN echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial main" >> /etc/apt/sources.list.d/clang.list && \
echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial main" >> /etc/apt/sources.list.d/clang.list && \
echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-7 main" >> /etc/apt/sources.list.d/clang.list && \
echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-7 main" >> /etc/apt/sources.list.d/clang.list && \
echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-8 main" >> /etc/apt/sources.list.d/clang.list && \
echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-8 main" >> /etc/apt/sources.list.d/clang.list

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - && apt -o Acquire::http::proxy=false update

RUN ["/bin/bash", "-c", "apt install -y clang-format-8 clang-tidy-8 clang-tools-8 && pushd /usr/bin && ln -s clangd-8 clangd && ln -s clang-tidy-8 clang-tidy && ln -s clang-tidy-diff-8.py clang-tidy-diff.py && ln -s clang-format-diff-8 clang-format-diff && ln -s clang-format-8 clang-format && popd"]

RUN locale-gen "en_US.UTF-8"

# Get the nightly build neovim for floating window
RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage && chmod +x nvim.appimage && ./nvim.appimage --appimage-extract && chmod 755 -R squashfs-root && rm nvim.appimage && rm `which nvim` && ln -s /squashfs-root/AppRun /usr/bin/nvim

# Install tmux
RUN ["/bin/bash", "-c", "TMUX_VERSION=2.9a &&       \
wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz &&    \
mkdir tmux-unzipped &&    \
tar xf tmux-${TMUX_VERSION}.tar.gz -C tmux-unzipped &&     \
rm -f tmux-${TMUX_VERSION}.tar.gz &&       \
pushd tmux-unzipped/tmux-${TMUX_VERSION} &&        \
./configure &&     \
make -j`nproc`&&        \
make install &&       \
popd &&        \
rm -rf tmux-unzipped"]
# -----------

# Install pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python3

# Install cmake via pip, install pygments for gtags, pynvim for neovim
RUN pip3 install cmake pygments pynvim thefuck

# Install gtags
RUN ["/bin/bash", "-c", "GTAGS_VERSION=6.6.3 &&     \
wget http://tamacom.com/global/global-$GTAGS_VERSION.tar.gz &&  \
mkdir gtags-unzipped && \
tar xf global-$GTAGS_VERSION.tar.gz -C gtags-unzipped && \
pushd gtags-unzipped/global-$GTAGS_VERSION &&  \
./configure &&  \
make && \
make install && \
popd && \
rm -rf gtags-unzipped"]

# Install ctags
RUN ["/bin/bash", "-c", "git clone --depth 1 https://github.com/universal-ctags/ctags.git && \
cd ctags && \
./autogen.sh  && \
./configure && \
make -j$(nproc) && \
make install && \
rm -rf ctags"]

COPY apply-format /usr/bin/
COPY clangformat-git-hook /usr/bin/
COPY clangtidy-git-hook /usr/bin/
COPY install-clangformat-hook /usr/bin/
COPY install-clangtidy-hook /usr/bin/

# Set timezone
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG USERNAME

# Add user "dev"
RUN useradd $USERNAME -m && echo "dev:dev" | chpasswd && usermod -aG sudo $USERNAME

# change shell to zsh for user dev
RUN chsh -s `which zsh` $USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME/

# Install node
RUN echo "dev" | sudo -S bash -c "$(wget -O- install-node.now.sh/lts)" -s --yes
# Install yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

# Install oh-my-zsh
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install autosuggestions and syntax-highlighting
RUN git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions /home/$USERNAME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$USERNAME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Add nvim config to share config with vim
RUN mkdir -p /home/$USERNAME/.config/nvim/ && \
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" >> /home/$USERNAME/.config/nvim/init.vim && \
echo "let &packpath=&runtimepath" >> /home/$USERNAME/.config/nvim/init.vim && \
echo "source ~/.vimrc" >> /home/$USERNAME/.config/nvim/init.vim
# -----------

COPY --chown=dev:dev .gitconfig /home/$USERNAME/
COPY --chown=dev:dev .vimrc /home/$USERNAME/
COPY --chown=dev:dev .vimrc.local /home/$USERNAME/
COPY --chown=dev:dev coc-settings.json /home/$USERNAME/.config/nvim/
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN vim +'PlugInstall --sync' +qa
RUN vim +'CocInstall coc-python coc-highlight coc-snippets coc-lists coc-git coc-yank coc-java -sync' +qa

RUN git clone --depth 1 https://github.com/gpakosz/.tmux.git /home/$USERNAME/.tmux/ &&    \
ln -s /home/$USERNAME/.tmux/.tmux.conf /home/$USERNAME/.tmux.conf
COPY --chown=dev:dev .tmux.conf.local /home/$USERNAME/

# Set PyPI mirror
RUN mkdir -p /home/$USERNAME/.config/pip && \
echo "[global]" >> /home/$USERNAME/.config/pip/pip.conf && \
echo "index-url = https://mirrors.ustc.edu.cn/pypi/web/simple" >> /home/$USERNAME/.config/pip/pip.conf && \
echo "format = columns" >> /home/$USERNAME/.config/pip/pip.conf
# -----------

# Copy .zshrc
COPY --chown=dev:dev .zshrc /home/$USERNAME/.zshrc
# Install fzf last so that the modified .zsrc will not be overwritted
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /home/$USERNAME/.fzf && /home/$USERNAME/.fzf/install --key-bindings --completion --update-rc
# -----------

