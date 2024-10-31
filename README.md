# Análise de Migração com Treetime Mugration

Este pipeline descreve o processo de análise de migração utilizando o Treetime Mugration. Abaixo, encontram-se os arquivos e passos necessários para realizar a análise.

## Arquivos Iniciais

1. **Árvore em escala temporal** (`timetree.nwk`)
2. **Arquivo de Metadados** (`states.tsv`) que deve conter as colunas:

   - `name`: Nome ou identificador da sequência
   - `region`: Região associada à sequência

## Exemplo de Formato do Arquivo de Metadados

O arquivo `states.tsv` deve estar formatado da seguinte forma:

```tsv
name    region
Sample1 Region1
Sample2 Region2
Sample3 Region3
...
```


  > **Nota:** Certifique-se de que a coluna `region` está formatada sem espaços, sem caracteres especiais e acentuações.
   > Para garantir que a coluna `region` esteja formatada corretamente, seguem alguns exemplos do que **não** deve conter:


## Passo a Passo

### 1. Executando o Mugration

Para realizar a análise de migração, use o comando abaixo:

```bash
treetime mugration --tree timetree.nwk --states states.tsv --attribute region
```

### 2. Preparando a Pasta de Scripts

1. Após a execução do comando acima, entre na pasta de saída gerada pelo Mugration.
2. Copie o arquivo `annotated_tree.nexus` para uma nova pasta que contenha os scripts `baltic.py` e `AncestralChanges.py`.

### 3. Contando Transições entre Regiões

Antes de realizar esta etapa, será necessário fazer um ajuste manual no script AncestralChanges.py
Na linha 12, deve inserir a data da sua sequência mais nova na árvore

Feito isso, passar para próxima etapa:
Na nova pasta criada, execute o seguinte comando no terminal (certifique-se de que `python3` está instalado):

```bash
python3 AncestralChanges.py
```

Esse comando gerará um arquivo `.csv` com três colunas: `"Year"`, `"Origin"`, e `"Destination"`.

### 4. Conversão para Matriz

1. O arquivo `.csv` gerado precisa ser convertido para uma matriz que servirá como input para a visualização dos dados no R.
2. A estrutura da matriz deve seguir o exemplo disponível na pasta "inputfiles" , com as regiões dispostas nas linhas e colunas. Os valores da matriz correspondem à soma dos eventos de migração entre cada par de regiões (de uma região X para uma região Y).
3. Para contar os valores a serem digitados na matriz, abra seu arquivo annotated_tree_events.csv
4. **Sugestão**: Para melhorar a visualização dos dados no gráfico, normalize os valores para LOG10

### 5. Plotagem do Gráfico com RStudio

1. Abra o RStudio e carregue o script `circos.R`.
2. Use a matriz como input para gerar o gráfico de migração.

## Resumo das etapas

```plaintext
├── timeTree_final.nwk
├── states.tsv
├── novapasta
│   ├── AncestralChanges.py
│   ├── baltic.py
│   ├── annotated_tree.nexus
│   └── annotated_tree_events.csv
└── rstudio_files
    ├── circos.R
    └── matriz.txt
```

## Notas Adicionais

- **Pré-requisitos**: Certifique-se de que `python3` e os pacotes necessários no R estão instalados.
