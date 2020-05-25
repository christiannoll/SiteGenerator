var worker = new Worker("search_worker.js");

function startSearchWorker(){
	worker.postMessage(["index", 0]);
}

function search(searchStr){
	worker.postMessage(["search", searchStr]);
}

worker.onmessage = function(e){
	var indices = e.data;
	if (indices.length > 0) {	
		applySearchResult(indices);
	}
	else {
		showAll();
	}
	console.log(indices);
}

function applySearchResult(indices) {
	var elements = document.getElementsByTagName("li");
	for (var element of elements) {
		element.style.display = 'none';
	}
	
	for (let index of indices) {
		var el = document.getElementById(index);
		if (el !== null) {
			el.style.display = 'list-item';
		} 
	} 
}

function showAll() {
	var elements = document.getElementsByTagName("li");
	for (let element of elements) {
		element.style.display = 'list-item';
	}
}