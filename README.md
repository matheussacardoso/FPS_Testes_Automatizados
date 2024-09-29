# FPS_Testes_Automatizados

## Equipe

- Bruno Souza
- Icaro Canela
- Joseph Neiva
- Matheus Sá
- Roberto Santana

## Descrição

Este projeto consiste em um script automatizado que executa testes em arquivos de código escritos em Python, C ou C++. O script identifica a linguagem do arquivo de entrada, compila o código (quando necessário), executa o código usando arquivos de teste fornecidos, compara a saída gerada com a saída esperada, e gera um relatório com os resultados dos testes. Além disso, o script faz um registro de cada execução em um arquivo CSV.

## Funcionalidades

- **Identificação automática da linguagem**: Suporta arquivos Python (`.py`), C (`.c`) e C++ (`.cpp`).
- **Compilação automática de arquivos C/C++**: Usa `gcc` para C e `g++` para C++.
- **Execução de testes**: Para cada arquivo de entrada de teste, o script executa o código e compara a saída com a saída esperada.
- **Relatório detalhado**: Gera um relatório com o número total de testes, testes bem-sucedidos, falhas e erros de execução.
- **Registro de execução em CSV**: Mantém um histórico de todas as execuções com informações sobre cada teste realizado.

## Pré-requisitos

Antes de executar o script, certifique-se de ter as seguintes dependências instaladas no seu sistema:

- **Python 3** (para testar arquivos `.py`)
- **GCC** e **G++** (para testar arquivos `.c` e `.cpp`)
- **PowerShell** (script desenvolvido para Windows)

## Como usar

1. **Clone este repositório**:
   ```bash
   git clone https://github.com/seuusuario/FPS_Testes_Automatizados.git
   cd FPS_Testes_Automatizados

2. Prepare seus arquivos de código:
- Certifique-se de que o arquivo de código esteja no formato adequado (.py, .c, ou .cpp).
- Prepare uma pasta de testes contendo arquivos de entrada (*.in) e arquivos de saída esperada (*.out).

3. Executar o script: Para executar o script, forneça o caminho para o arquivo de código e o diretório contendo os arquivos de teste:
Em powershell:
   ```powershell
   .\script.ps1 -InputPath <caminho_para_arquivo> -TestsPath <caminho_para_pasta_de_testes>

4. Ver o Relatório: O script gera um relatório de execução diretamente no terminal com o número de testes executados, quantos passaram, quantos falharam e se houve erros.

5. Registro de Execuções: Todas as execuções são registradas em um arquivo CSV chamado execution_log.csv. Ele armazena informações como:
- Data e hora da execução
- Caminho do arquivo testado
- Pasta dos testes
- Total de testes executados
- Quantos testes passaram, falharam e tiveram erros

Exemplo do resultado no arquivo cs:
```bash
2024-09-28 10:30:00, ./exemplo/main.py, ./exemplo/tests/, 5, 4, 1, 0
