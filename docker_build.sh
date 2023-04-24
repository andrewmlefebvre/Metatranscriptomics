#conda env export > environment.yml
#pip3 list --format=freeze --exclude-editable > requirements.txt
docker build -t marmma . 
docker tag marmma andrewmlefebvre/marmma:latest
docker push andrewmlefebvre/marmma:latest