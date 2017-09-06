for fastq in $(find $1 -name "*.fastq.gz")
do
   tmp=${fastq##*/}
   prefix=${tmp%%.*}
   gunzip -c $fastq > tmp/${prefix}.fastq
   cd tmp
   awk '{if(NR%4 == 1){print ">" substr($0, 2)}}{if(NR%4 == 2){print}}' ${prefix}.fastq > ${prefix}.fasta
   rm ${prefix}.fastq
   blastn -query ${prefix}.fasta -db /mnt/sdd/yangmy/PaVE/PaVE.fasta -outfmt 6 -out ${prefix}.tab -max_target_seqs 50 -num_threads 30
   awk -F"\t" '{print $1"\t"$2"\t"$3"\t"$4"\t"$11"\t"$12}' ${prefix}.tab >${prefix}.score
   awk -F"\t" '{if( $4 > 106 && $3 >85 ){print $0}}' ${prefix}.score |sort -t $'\t' -s -k1,1 -k3,3nr -k6,6nr -k5,5nr >${prefix}.score.flt.srt
   perl ../get_type.pl ${prefix}.score.flt.srt
   mv *.tab ../output
   mv *.type ../output
done
#rm *.flt *.fasta *.score
