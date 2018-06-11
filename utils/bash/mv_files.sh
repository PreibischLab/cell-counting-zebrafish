for f in data/images/non-processed/fish_*
	do 
		prefix=$(basename $f)
		echo $prefix
		cp $f"/mask.jpg" "data/images/processed/"$prefix"-mask.jpg"  
		cp $f"/mask.png" "data/images/processed/"$prefix"-mask.png"  
done
