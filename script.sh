#!/bin/bash

# Função para exibir como usar o script
usage() {
    echo "Uso: $0 --input caminho_para_arquivo --tests caminho_para_pasta_de_testes"
    echo "Exemplo: $0 -i ./exemplo/main.py -t ./exemplo/tests/"
    exit 1
}

# Função para identificar a linguagem do código
identify_language() {
    extension="${1##*.}"
    case "$extension" in
        py)
            echo "python"
            ;;
        c)
            echo "c"
            ;;
        cpp)
            echo "cpp"
            ;;
        *)
            echo "Erro: Extensão de arquivo desconhecida."
            exit 1
            ;;
    esac
}

# Função para compilar código C/C++
compile_code() {
    if [ "$language" == "c" ]; then
        gcc "$input_file" -o program || { echo "Erro ao compilar código C"; exit 1; }
    elif [ "$language" == "cpp" ]; then
        g++ "$input_file" -o program || { echo "Erro ao compilar código C++"; exit 1; }
    fi
}

# Função para executar o código
execute_code() {
    if [ "$language" == "python" ]; then
        python3 "$input_file" < "$test_input" > output.txt
    elif [ "$language" == "c" ] || [ "$language" == "cpp" ]; then
        ./program < "$test_input" > output.txt
    fi
}

# Função para comparar saídas
compare_outputs() {
    if diff -q output.txt "$expected_output" > /dev/null; then
        echo "Teste $test_number: Sucesso"
        return 0
    else
        echo "Teste $test_number: Falha"
        echo "Diferenças:"
        diff output.txt "$expected_output"
        return 1
    fi
}

# Função para registrar execução em CSV
log_execution() {
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    total_tests=$1
    passed_tests=$2
    failed_tests=$3
    error_tests=$4

    echo "$timestamp, $input_file, $tests_folder, $total_tests, $passed_tests, $failed_tests, $error_tests" >> execution_log.csv
}

# Parsing de argumentos
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--input) input_file="$2"; shift ;;
        -t|--tests) tests_folder="$2"; shift ;;
        *) usage ;;
    esac
    shift
done

# Verificação dos argumentos
if [ -z "$input_file" ] || [ -z "$tests_folder" ]; then
    usage
fi

# Identificar linguagem
language=$(identify_language "$input_file")

# Compilar o código se necessário
if [ "$language" == "c" ] || [ "$language" == "cpp" ]; then
    compile_code
fi

# Variáveis para contagem de testes
total_tests=0
passed_tests=0
failed_tests=0
error_tests=0

# Executar os testes
for test_input in "$tests_folder"/*.in; do
    total_tests=$((total_tests + 1))
    test_number=$(basename "$test_input" .in)
    expected_output="$tests_folder/$test_number.out"
    
    # Tentar executar o código
    if execute_code; then
        # Comparar a saída
        if compare_outputs; then
            passed_tests=$((passed_tests + 1))
        else
            failed_tests=$((failed_tests + 1))
        fi
    else
        echo "Erro ao executar o teste $test_number"
        error_tests=$((error_tests + 1))
    fi
done

# Relatório final
echo "==========================="
echo "Relatório Final:"
echo "Total de Testes: $total_tests"
echo "Testes com Sucesso: $passed_tests"
echo "Testes com Falha: $failed_tests"
echo "Testes com Erro: $error_tests"
echo "==========================="

# Registrar a execução em CSV
log_execution $total_tests $passed_tests $failed_tests $error_tests

# Limpeza
rm -f output.txt program

