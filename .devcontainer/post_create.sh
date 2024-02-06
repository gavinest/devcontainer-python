#!/usr/bin/env bash
set -euxo pipefail

mkdir -p /commandhistory
touch /commandhistory/.zsh_history
chown -R ${USER} /commandhistory

echo "autoload -Uz add-zsh-hook; append_history() { fc -W }; add-zsh-hook precmd append_history; export HISTFILE=/commandhistory/.zsh_history" >> /home/${USER}/.zshrc
echo "PATH=\".venv/bin:${PATH}\"" >> /home/${USER}/.zshrc
echo "PATH=\"${PWD}/.venv/bin:${PATH}\"" >> /home/${USER}/.zshrc

pip install --upgrade pip \
    && pip install poetry \
    && poetry config virtualenvs.in-project true \
    && poetry config cache-dir ./ \
    && poetry install --with=dev --no-root