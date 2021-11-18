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
		</style>
		
		<script type="text/javascript">
		
			function buscarInformacoes(){
				
				
			}
		
		</script>
	</head>
	<body>
	
		<h1>Informações de aves</h1>
		
		<div id="div-nome">
			Ave:
			<select id="nomeAve" onclick="buscarInformacoes()">
				<c:forEach var="ave" items="${aves}">
					<option value="${ave}">${ave}</option>
				</c:forEach>
			</select>
		</div>
				
		<table id="informacoesAve">
		</table>
		
	</body>
</html>