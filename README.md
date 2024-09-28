# FPS_Testes_Automatizados

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
   git clone https://github.com/seuusuario/test-automation-script.git
   cd test-automation-script
