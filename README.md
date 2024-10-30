
# Análise de Migração com Treetime Mugration

Este pipeline detalha o processo de análise de migração utilizando o Treetime Mugration. São necessários dois arquivos iniciais:

1. Uma árvore em escala temporal (`timeTree_final.nwk`)
2. Um arquivo de metadados (`states.tsv`) com as colunas:

   - `name`: Nome ou identificador da sequência
   - `region`: Região associada à sequência
  
## Exemplo de Formato do Metadata

O arquivo `states.tsv` deve ter o seguinte formato:

```tsv
name    region
Sample1 Region1
Sample2 Region2
Sample3 Region1
...
```     

## Passo a Passo

### 1. Rodando o Mugration

Execute o comando abaixo para realizar a análise de migração:

```bash
treetime mugration --tree timeTree_final.nwk --states states.tsv --attribute region
```

Após a execução, pegar o arquivo annotated_tree.nexus e colocar na mesma pasta do baltic.py + AncestralChanges.py

### 2. Contando Transições entre Regiões

No terminal Linux, com `python3` instalado, execute:

```bash
python3 AncestralChanges.py
```

Este comando gerará um arquivo `.csv` com informações para a próxima etapa.

### 3. Conversão para Matriz

O arquivo `.csv` gerado precisa ser convertido para uma matriz, que servirá de input para visualização no R.

### 4. Plotagem do Gráfico com RStudio

No RStudio, rode o script `Circus.R`, usando a matriz como input para gerar o gráfico de migração.

## Estrutura dos Arquivos

```plaintext
.
├── timeTree_final.nwk
├── states.tsv
├── ancestral_changes
│   ├── AncestralChanges.py
│   ├── [outros arquivos necessários]
└── Circus.R
```

## Notas

- **Requisitos**: Certifique-se de que o `python3` esteja instalado.


