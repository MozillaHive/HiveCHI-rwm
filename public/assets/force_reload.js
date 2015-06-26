proper_url = window.location.origin.concat("/",document.getElementById("proper_url").value)
document.getElementById("options").innerHTML = proper_url
if (window.location.href != proper_url){
	window.location.replace(proper_url)
}