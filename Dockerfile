FROM python:3.12-alpine as builder

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY 'python_can_coe-0.0.0-py3-none-any.whl' ./
RUN pip install python_can_coe-0.0.0-py3-none-any.whl

FROM python:3.12-alpine

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY coe2mqtt .

CMD [ "python", "./coe2mqtt" ]
