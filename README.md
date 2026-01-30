# Automatização de abertura do Expediente Digital em monitor secundário

## Contexto e problema
O novo sistema de gestão processual da Defensoria é baseado em navegador web. Ao consultar os autos (“Expediente Digital”), o sistema abre o conteúdo em uma nova aba ou janela do navegador, sem permitir controle sobre em qual monitor a visualização ocorrerá.

No ambiente de trabalho da Defensoria:
- os defensores utilizam dois monitores;
- o monitor secundário é frequentemente configurado em orientação retrato, dedicado à leitura dos autos;
- o fluxo de trabalho exige alternância rápida entre edição de texto e leitura processual.

Os navegadores modernos (Chrome, Edge, Firefox) não permitem que aplicações web escolham diretamente o monitor de abertura, por limitação de segurança do próprio navegador.

## Solução adotada
Foi desenvolvida uma ferramenta local, portátil, baseada em AutoHotkey v2, que:
- monitora janelas abertas do navegador;
- identifica janelas cujo título contenha “Expediente Digital”;
- detecta automaticamente qual monitor está em orientação retrato;
- move a janela do “Expediente Digital” para esse monitor;
- maximiza a janela, ocupando todo o monitor secundário.

A solução não altera o sistema web, não interfere no navegador e não exige permissões administrativas.

## Funcionamento resumido
1. O usuário abre o “Expediente Digital” em nova janela (Shift + clique).
2. O executável roda em segundo plano.
3. Ao detectar a janela:
   - identifica o monitor em retrato;
   - move a janela para esse monitor;
   - maximiza automaticamente.
4. Após a primeira movimentação, o usuário pode reposicionar a janela manualmente sem que o programa a mova novamente.

## Tecnologias utilizadas
- AutoHotkey v2

Compatível com:
- Google Chrome
- Microsoft Edge
- Mozilla Firefox

Sistema operacional:
- Windows 10 / Windows 11

## Segurança e impacto no sistema
O executável gerado:
- ❌ não instala software no sistema;
- ❌ não grava no registro do Windows;
- ❌ não cria serviços ou drivers;
- ❌ não modifica configurações do sistema;
- ❌ não coleta dados.

Trata-se de um executável portátil, que:
- roda apenas enquanto estiver em execução;
- pode ser removido simplesmente apagando o arquivo.

## Instalação e remoção
### Instalação
1. Copiar o arquivo `ExpedienteDigital_Retrato_Max.exe` para o computador.
2. (Opcional) Criar um atalho na pasta de inicialização:
   - Win + R → `shell:startup`

### Remoção
1. Encerrar o programa (ícone próximo ao relógio).
2. Apagar o arquivo executável.
3. Remover o atalho da inicialização, se houver.

## Limitações conhecidas
- O navegador não permite mover abas individualmente.
- O “Expediente Digital” precisa ser aberto em nova janela (Shift + clique).
- A solução depende da existência de um monitor em orientação retrato.

## Manutenção
O código-fonte está disponível neste repositório.

O executável pode ser recompilado a partir do script `.ahk` usando o compilador oficial `Ahk2Exe`.

Alterações futuras (ex.: novo título da janela) exigem apenas ajuste no script.
