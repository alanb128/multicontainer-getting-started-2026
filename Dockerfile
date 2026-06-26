FROM python:3.12-alpine

WORKDIR /code

# Set environment variables used by the `flask` command:
ENV FLASK_APP=app.py  
ENV FLASK_RUN_HOST=0.0.0.0

# Install `gcc` and other dependencies:
RUN apk add --no-cache gcc musl-dev linux-headers redis

# Copies the current directory `.` in the project to the workdir `.` in the image:
COPY . .  

# Installs the Python dependencies:
RUN pip install -r requirements.txt  

RUN chmod +x healthcheck.sh

EXPOSE 5000

CMD ["./healthcheck.sh"]
