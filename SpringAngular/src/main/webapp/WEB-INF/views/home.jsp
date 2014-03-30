<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html ng-app="userTest">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap 101 Template</title>

<!-- Bootstrap -->
<link href="<spring:url value="resources/css/bootstrap.min.css" />"
	rel="stylesheet">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<div ng-controller="userCtrl">
		<input ng-model="user.username" /> <input ng-model="user.password" />
		<button ng-click="addUser()">add user</button>
		
		<table class="table table-strip">
			<tr ng-repeat="user in users">
				<td>{{ user.username }}</td>
				<td><button ng-click="deleteUser(user.username)" class="btn btn-default">
						<i class="glyphicon glyphicon-remove"></i>
					</button></td>
			</tr>
		</table>
	</div>



	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="<spring:url value="resources/js/bootstrap.min.js" />"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0-beta.2/angular.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0-beta.2/angular-route.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0-beta.2/angular-resource.min.js"></script>

	<script type="text/javascript">
		angular.module('userTest', [ 'ngResource' ]);

		function userCtrl($scope, $resource) {
			var url = "http://localhost:8080/test/";
			var User = $resource(url + "user/:id", {
				id : '@id'
			});

			$scope.addUser = function() {
				// $scope.users.push({username : $scope.userName});
				User.save($scope.user, function() {
					$scope.sync();
				});
			};
			$scope.deleteUser = function(username) {
				User.remove({
					id : username
				}, function() {
					$scope.sync();
				});
			};

			$scope.sync = function() {
				$scope.users = User.query();
			};
			
			$scope.sync();
		}
	</script>
</body>
</html>