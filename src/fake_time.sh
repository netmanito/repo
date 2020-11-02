while true
do
    real_sec=$(date +"%S")
    fake_sec=$(expr $real_sec - 1)

    fake_time=$(date +"%H")":"$(date +"%M")":"$fake_sec
    date -s $fake_time
   
    sleep 2
done