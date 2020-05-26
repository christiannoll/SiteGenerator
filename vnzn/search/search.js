var worker = new Worker("search_worker.js");

function startSearchWorker(){
	worker.postMessage(["index", 0]);
}

function search(searchStr){
	if (searchStr.length > 2) {
		worker.postMessage(["search", searchStr]);
	}
	else {
		showAll();
	}
}

worker.onmessage = function(e){
	var indices = e.data;	
	applySearchResult(indices);
	//console.log(indices);
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