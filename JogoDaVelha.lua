--[Logic]--
tabuleiro = {}
vencedor = "\0"
jogador = 0
celula = 0
nColunas = 0
nLinhas = 0


--[Inicializa Matriz Tabuleiro]--
function inicializaMatriz(tabuleiro)
	if(jogador == 0) then
		for i = 0, 2 do
			tabuleiro[i] = {}
			for j = 0,2 do
				tabuleiro[i][j] = 3*i + (j + 1)
			end
		end
	end
end

--[Tabuleiro]--
function printTabuleiro(tabuleiro)
	for i = 0,2 do
				print(tabuleiro[i][0]," | ", tabuleiro[i][1], " | ", tabuleiro[i][2])
			end
end

--[Pede Informação ao Jogador]--
function promptJogador(jogador)
	if (jogador == 1) then
		print("Jogador " .. jogador .. ", escolha o número da posição onde quer jogar seu X")
	else 
		print("Jogador " .. jogador .. ", escolha o número da posição onde quer jogar seu O")
	end
end	

--[Recebe Espaço Desejado]--
function recebeEspaco()
	while(celula > 9 or celula < 1) do 
		celula = io.read("*n")
		if(celula > 9 or celula < 1) then
	    	print("Número inválido, tente novamente")
	 	end
	end
end

--[Verifica Espaços Ocupados]--
function verificaEspaco()
	if((tabuleiro[nLinhas][nColunas] == "X") or (tabuleiro[nLinhas][nColunas] == "O")) then
		print("Espaço já está ocupado, tente novamente")	
	else 
		if(jogador == 1) then
			tabuleiro[nLinhas][nColunas] = "X"
		else
			tabuleiro[nLinhas][nColunas] = "O"
		end
		i = i + 1
	end
end

--[Checa Vitoria]--
function checaVitoria(tabuleiro)
	local atual
	local winner = "\0" 
	
	--[Checa Linhas]--
	for i = 0, 2 do
		atual = tabuleiro[i][0]
		for j = 0, 2 do
			if(tabuleiro[i][j] ~= atual) then
				atual = "\0";
			end
		end
		if(atual ~= "\0") then
			winner = atual
	end	
	
	--[Checa Colunas]--
	for i = 0,2 do
		atual = tabuleiro[0][i]
		for j = 0,2 do
			if(tabuleiro[j][i] ~= atual) then
				atual = "\0"
			end
		end
		if(atual ~= "\0") then
			winner = atual
		end
	end
		
	--[Checa diagonal]--
	atual = tabuleiro[0][0]
	for i = 0,2 do
		if(tabuleiro[i][i] ~= atual) then
			atual = "\0"
		end
	end
	if(atual ~= "\0") then
		winner = atual
	end
	atual = tabuleiro[0][2]
	for i = 0,2 do
		if(tabuleiro[i][2-i] ~= atual) then
			atual = "\0"
		end
	end
	if(atual ~= "\0") then
		winner = atual
	end
	return winner	
end
end

--[Imprime Mensagem ao Vencedor]--
function congratulaVencedor()
	if (vencedor ~= "\0") then
	  printTabuleiro(tabuleiro)
		print("Parabéns Jogador " .. jogador.. ". Você venceu!")
	end
end


--[Imprime Mensagem de Empate]--
function empate()	
	if(i == 9 and vencedor == "\0") then
  		print("Empate!")
	end
end
--[Jogo da Velha]--

inicializaMatriz(tabuleiro)
i = 0
while(vencedor == "\0") and ( i < 9) do
	printTabuleiro(tabuleiro)
	jogador = (i%2) + 1
	promptJogador(jogador)
	
	celula = 0
	recebeEspaco()

	celula = celula - 1
	nColunas = celula % 3
	celula = celula - nColunas 
	nLinhas = celula/3
	
	verificaEspaco()
	
	vencedor = checaVitoria(tabuleiro)
	
	congratulaVencedor()
end

empate()
