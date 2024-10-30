# Análise de Migração com Treetime Mugration

Este pipeline detalha o processo de análise de migração utilizando o Treetime Mugration. São necessários dois arquivos iniciais:

1. Uma árvore em escala temporal (`timeTree_final.nwk`)
2. Um arquivo de metadados (`states.tsv`) com as colunas:

   - `name`: Nome ou identificador da sequência
   - `region`: Região associada à sequência

> **Nota:** A coluna `region` deve ser formatada sem espaços e sem caracteres especiais.

## Exemplo de Formato do Metadata

O arquivo `states.tsv` deve seguir este formato:

```tsv
name    region
Sample1 Region1
Sample2 Region2
Sample3 Region3
...
```

## Passo a Passo

### 1. Rodando o Mugration

Execute o comando abaixo para realizar a análise de migração:

```bash
treetime mugration --tree timeTree_final.nwk --states states.tsv --attribute region
```

Após a execução, entre na pasta de output gerada pelo Mugration e copie o arquivo `annotated_tree.nexus` para uma nova pasta que contenha os scripts `baltic.py` e `AncestralChanges.py`.

### 2. Contando Transições entre Regiões

Na nova pasta criada, execute o seguinte comando no terminal Linux, assumindo que `python3` está instalado:

```bash
python3 AncestralChanges.py
```

Esse comando gerará um arquivo `.csv` com três colunas: `"Year"`, `"Origin"`, e `"Destination"`.

### 3. Conversão para Matriz

O arquivo `.csv` gerado precisa ser convertido para uma matriz, que servirá de input para a visualização dos dados no R.

### 4. Plotagem do Gráfico com RStudio

No RStudio, rode o script `Circus.R`, usando a matriz como input para gerar o gráfico de migração.

## Estrutura dos Arquivos

```plaintext
.
├── timeTree_final.nwk
├── states.tsv
├── novapasta
│   ├── AncestralChanges.py
│   ├── baltic.py
│   ├── annotated_tree.nexus
└── Circus.R
```

## Notas

- **Requisitos**: Certifique-se de que o `python3` esteja instalado no sistema.
