#! /bin/bash
set +x

wget https://download.postgresql.org/pub/repos/yum/9.3/redhat/rhel-5-x86_64/pgdg-centos93-9.3-2.noarch.rpm
rpm -ivh pgdg-centos93-9.3-2.noarch.rpm
yum install postgresql93-devel -y

ln -s /usr/pgsql-9.3/bin/pg_config /usr/bin/pg_config

for PYBIN in /opt/python/*/bin; do
    # ${PYBIN}/pip install -r /io/dev-requirements.txt
    ${PYBIN}/pip wheel /io/ -w wheelhouse/
done

# Bundle external shared libraries into the wheels
for whl in wheelhouse/*.whl; do
    auditwheel repair $whl -w /io/wheelhouse/
done

