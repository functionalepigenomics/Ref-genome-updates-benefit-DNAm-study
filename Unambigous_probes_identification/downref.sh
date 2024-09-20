cat assm_accs.txt | while read -r acc ; do
    esearch -db assembly -query $acc </dev/null \
        | esummary \
        | xtract -pattern DocumentSummary -element FtpPath_GenBank \
        | while read -r url ; do
            fname=$(echo $url | grep -o 'GCA_.*' | sed 's/$/_genomic.fna.gz/') ;
            mkdir "$fname"
            cd "$fname"
            wget "$url/$fname" ;
	    cd ..
        done ;
    done
