# Função para exibir como usar o script
function Show-Usage {
    Write-Host "Uso: .\script.ps1 -InputPath caminho_para_arquivo -TestsPath caminho_para_pasta_de_testes"
    Write-Host "Exemplo: .\script.ps1 -InputPath ./exemplo/main.py -TestsPath ./exemplo/tests/"
    exit
}

# Função para identificar a linguagem do código
function Identify-Language {
    param($InputFile)
    $extension = [System.IO.Path]::GetExtension($InputFile).TrimStart(".")
    
    switch ($extension) {
        "py" { return "python" }
        "c"  { return "c" }
        "cpp" { return "cpp" }
        default {
            Write-Host "Erro: Extensão de arquivo desconhecida."
            exit
        }
    }
}

# Função para compilar código C/C++
function Compile-Code {
    param($Language, $InputFile)
    if ($Language -eq "c") {
        gcc $InputFile -o program.exe
        if ($LASTEXITCODE -ne 0) { Write-Host "Erro ao compilar código C"; exit }
    }
    elseif ($Language -eq "cpp") {
        g++ $InputFile -o program.exe
        if ($LASTEXITCODE -ne 0) { Write-Host "Erro ao compilar código C++"; exit }
    }
}

# Função para executar o código
function Execute-Code {
    param($Language, $InputFile, $TestInput)

    if ($Language -eq "python") {
        python $InputFile < $TestInput > output.txt
    }
    elseif ($Language -eq "c" -or $Language -eq "cpp") {
        .\program.exe < $TestInput > output.txt
    }
}

# Função para comparar saídas
function Compare-Outputs {
    param($ExpectedOutput, $TestNumber)
    
    $result = Compare-Object (Get-Content output.txt) (Get-Content $ExpectedOutput)
    
    if ($result.Count -eq 0) {
        Write-Host "Teste $TestNumber: Sucesso"
        return $true
    } else {
        Write-Host "Teste $TestNumber: Falha"
        Write-Host "Diferenças:"
        $result | ForEach-Object { $_ }
        return $false
    }
}

# Função para registrar execução em CSV
function Log-Execution {
    param($TotalTests, $PassedTests, $FailedTests, $ErrorTests)

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp, $InputFile, $TestsFolder, $TotalTests, $PassedTests, $FailedTests, $ErrorTests"
    
    Add-Content -Path "execution_log.csv" -Value $logEntry
}

# Parsing de argumentos
param (
    [string]$InputPath,
    [string]$TestsPath
)

if (-not $InputPath -or -not $TestsPath) {
    Show-Usage
}

# Identificar linguagem
$language = Identify-Language -InputFile $InputPath

# Compilar o código se necessário
if ($language -eq "c" -or $language -eq "cpp") {
    Compile-Code -Language $language -InputFile $InputPath
}

# Variáveis para contagem de testes
$totalTests = 0
$passedTests = 0
$failedTests = 0
$errorTests = 0

# Executar os testes
$testFiles = Get-ChildItem "$TestsPath\*.in"

foreach ($testInput in $testFiles) {
    $totalTests++
    $testNumber = [System.IO.Path]::GetFileNameWithoutExtension($testInput)
    $expectedOutput = "$TestsPath\$testNumber.out"

    try {
        Execute-Code -Language $language -InputFile $InputPath -TestInput $testInput.FullName

        if (Compare-Outputs -ExpectedOutput $expectedOutput -TestNumber $testNumber) {
            $passedTests++
        } else {
            $failedTests++
        }
    } catch {
        Write-Host "Erro ao executar o teste $testNumber"
        $errorTests++
    }
}

# Relatório final
Write-Host "==========================="
Write-Host "Relatório Final:"
Write-Host "Total de Testes: $totalTests"
Write-Host "Testes com Sucesso: $passedTests"
Write-Host "Testes com Falha: $failedTests"
Write-Host "Testes com Erro: $errorTests"
Write-Host "==========================="

# Registrar a execução em CSV
Log-Execution -TotalTests $totalTests -PassedTests $passedTests -FailedTests $failedTests -ErrorTests $errorTests

# Limpeza
Remove-Item output.txt, program.exe -ErrorAction Ignore

