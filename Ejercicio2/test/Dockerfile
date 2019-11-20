FROM python:alpine3.10

RUN pip install requests && \
    pip install retry

COPY tests.py .
RUN chmod +x tests.py

CMD ["python", "./tests.py"]
#ENTRYPOINT ["./tests.py"]

