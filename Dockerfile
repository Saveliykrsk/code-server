FROM node:20.18.2

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    libx11-dev \
    libxkbfile-dev \
    && rm -rf /var/lib/apt/lists/*

# Установка yarn (если используется вместо npm)
RUN npm install -g yarn

# Копирование проекта
WORKDIR /app
COPY . .

# Установка зависимостей проекта
RUN yarn install --frozen-lockfile || npm install

# Сборка проекта
RUN yarn build || npm run build

# Запуск
CMD ["yarn", "start"]
