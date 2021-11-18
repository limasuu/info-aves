<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
	<head>
		<meta charset="UTF-8">
		<title>Informações de aves</title>
		
		<style>
			body{
				display: flex;
				flex-direction: column;
				align-items: center;	
			}			
			table, td{
				border: 1px solid black;
				border-collapse: collapse;
				margin: 20px;
				padding: 5px;
			}
		</style>
		
		<script type="text/javascript">
		
			function buscarInformacoes(){
				
				var ajax= new XMLHttpRequest();
				var url= "/info-aves/aves.xml";
				
				ajax.onreadystatechange= function(){
					if(ajax.readyState == 4 && ajax.status == 200){
						
						var nomeAve= document.getElementById("nomeAve").value;		
						var tabela= document.getElementById("informacoesAve");
						tabela.innerHTML= "";						
						if(nomeAve != ""){
							
							var xml= ajax.responseXML;
							var aves= xml.getElementsByTagName("ave");								
							
							var ave= aves.item(nomeAve);
							var infos= ave.childNodes; 
							
							for(var i=0; i< infos.length; i++){							
								var info= infos.item(i);								
								if(info.hasChildNodes()){								
									
									var linha= document.createElement("tr");
								
									var celula1= document.createElement("td");
									celula1.innerHTML= info.nodeName;
									
									var celula2= document.createElement("td");
									celula2.innerHTML= info.firstChild.nodeValue;
									
									linha.appendChild(celula1);
									linha.appendChild(celula2);
									tabela.appendChild(linha);
								}
							}						
						}	
					}
				};
				
				ajax.open("GET", url, true);
				ajax.send();
			}
		
		</script>
	</head>
	<body>
	
		<h1>Informações de aves</h1>
		
		<div id="div-nome">
			Ave:
			<select id="nomeAve" onchange="buscarInformacoes()">
				<option value="">Selecione</option>
				<c:forEach var="ave" items="${aves}" varStatus="loop">
					<option value="${loop.index}">${ave}</option>
				</c:forEach>
			</select>
		</div>
				
		<table id="informacoesAve">
		</table>
		
	</body>
</html>