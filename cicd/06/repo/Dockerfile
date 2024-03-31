FROM centos:7

RUN yum -y install epel-release python3 python3-pip git && yum clean all

WORKDIR /app

COPY python-api/requirements.txt .
RUN pip3 install --upgrade pip && pip3 install --no-cache-dir -r requirements.txt

ADD python-api/python-api.py .

ENTRYPOINT [ "python3","/app/python-api.py" ]
EXPOSE 5290
