<html>
<head>
<title>Active Job Dashboard</title>
<script>
setTimeout(function() {
    window.location = window.location;
}
, 10000);
</script>
</head>
<body>
<table>
<form action='/' method='POST'>
<button type='submit' name='reset' value='true'>Reset Statistics</button>
</form>
% include('row', values=headers, header=True)
% for row in rows:
	% include('row', values=row, header=False)
% end
</table>
</body>
</html>