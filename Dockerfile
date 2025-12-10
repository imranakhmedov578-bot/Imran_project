FROM python:3.10-slim

WORKDIR /app

# Устанавливаем системные зависимости (иногда нужны для сборки пакетов)
RUN apt-get update && apt-get install -y build-essential

# Копируем зависимости
COPY requirements.txt .

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Проверяем, что uvicorn действительно установлен
RUN python -m pip show uvicorn && echo "✅ Uvicorn успешно установлен"

# Копируем остальной проект
COPY . .

EXPOSE 8000

# Запуск через python -m uvicorn (гарантирует, что Python найдёт модуль)
CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
