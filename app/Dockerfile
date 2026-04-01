FROM python:3.11-slim
  
WORKDIR /app
 
ENV PYTHONDONTWRITEBYTECODE=1

ENV PYTHONUNBUFFERED=1 
 
RUN pip install --upgrade pip 
 
RUN apt-get update \
    && apt-get -y install libpq-dev gcc

COPY requirements.txt .
 
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["sh", "-c", "python manage.py migrate && python manage.py collectstatic --noinput && gunicorn --bind 0.0.0.0:8000 django_pkms.wsgi:application"]