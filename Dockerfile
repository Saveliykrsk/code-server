FROM node:20.18.2

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    libx11-dev \
    libxkbfile-dev \
    && rm -rf /var/lib/apt/lists/*

# Установка yarn через curl
RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.22.19 && \
    ln -s /root/.yarn/bin/yarn /usr/local/bin/yarn

# Копирование проекта
WORKDIR /app
COPY . .

# Установка зависимостей проекта
RUN yarn install --frozen-lockfile || npm install

# Сборка проекта
RUN yarn build || npm run build

# Запуск
CMD ["yarn", "start"]
