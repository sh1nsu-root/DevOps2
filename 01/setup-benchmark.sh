#!/bin/bash

# 1
echo "Benchmark"
PROJECT_DIR="example-app-nodejs-backend-react-frontend"

# 2
if [ ! -d "$PROJECT_DIR" ]; then
    echo "$PROJECT_DIR не найдена"
    exit 1
fi

cd "$PROJECT_DIR"

# 3
echo "Node.js: $(node --version)"
echo "npm: $(npm --version)"
echo "yarn: $(yarn --version)"
rm -rf node_modules package-lock.json yarn.lock

# 4
START_TIME=$(date +%s.%N)
npm install --silent > /dev/null 2>&1
END_TIME=$(date +%s.%N)
NPM_TIME=$(echo "$END_TIME - $START_TIME" | bc -l)
printf "npm install: %.2f секунд\n" $NPM_TIME

# 5
if [ -f "package-lock.json" ]; then
    cp package-lock.json package-lock.json.backup
fi

rm -rf node_modules package-lock.json

# 6
START_TIME=$(date +%s.%N)
yarn install --silent > /dev/null 2>&1
END_TIME=$(date +%s.%N)
YARN_TIME=$(echo "$END_TIME - $START_TIME" | bc -l)
printf "yarn install: %.2f секунд\n" $YARN_TIME

# 7
printf "npm:  %.2f секунд\n" $NPM_TIME
printf "yarn: %.2f секунд\n" $YARN_TIME

WINNER=$(echo "$NPM_TIME < $YARN_TIME" | bc -l)
if [ $WINNER -eq 1 ]; then
    DIFF=$(echo "$YARN_TIME - $NPM_TIME" | bc -l)
    printf "npm БЫСТРЕЕ на %.2f секунд!\n" $DIFF
    PERCENT=$(echo "scale=1; ($DIFF / $YARN_TIME) * 100" | bc -l)
    printf "   (на %.1f%% быстрее)\n" $PERCENT
else
    DIFF=$(echo "$NPM_TIME - $YARN_TIME" | bc -l)
    printf "yarn БЫСТРЕЕ на %.2f секунд!\n" $DIFF
    PERCENT=$(echo "scale=1; ($DIFF / $NPM_TIME) * 100" | bc -l)
    printf "   (на %.1f%% быстрее)\n" $PERCENT
fi

# 8
if [ -f "package-lock.json.backup" ]; then
    mv package-lock.json.backup package-lock.json
fi

# 9
echo "1. Benchmark - $PROJECT_DIR"
echo "2. Проверяем наличие папки $PROJECT_DIR"
echo "3. Выводим версии Node.js, npm, yarn"
echo "4. Удаляем node_modules и package-lock.json"
echo "5. Запускаем npm install"
echo "6. Запускаем yarn install"
echo "7. Сравниваем время установки зависимостей"
echo "8. Восстанавливаем package-lock.json"
echo "9. The end"
echo "Для замера скорости удаляем npm и yarn, так получим чистые результаты"