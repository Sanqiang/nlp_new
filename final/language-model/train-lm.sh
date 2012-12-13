#! /bin/bash

${IRSTLM:?"Environment variable undefined. Example: export IRSTLM=\$HOME/irstlm"}
${MOSES:?"Environment variable undefined. Example: export IRSTLM=\$HOME/mosesdecoder"}

echo "Denoting starts and ends of sentences..."
./add-start-end.scala ../tokenization/shiji.tokenized.classical shiji.tokenized.sb.classical

echo "Building language model..."
$IRSTLM/bin/build-lm.sh -i shiji.tokenized.sb.classical -t ./tmp -p -s improved-kneser-ney -o lm.classical

echo "Compiling language model to ARPA..."
$IRSTLM/bin/compile-lm --text yes lm.classical.gz lm.arpa.classical

echo "Compiling ARPA with KenLM..."
$MOSES/bin/build_binary lm.arpa.classical lm.b.classical
