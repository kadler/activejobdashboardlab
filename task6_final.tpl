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
<form action='/' method='POST'>
<div>Elapsed time: {{elapsed_time}}
<button type='submit' name='reset' value='true'>Reset Statistics</button>
</div>
</form>
<table>
% include('row', values=headers, header=True)
% for row in rows:
	% include('row', values=row, header=False)
% end
</table>
</body>
</html>