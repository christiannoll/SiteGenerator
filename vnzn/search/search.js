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
	let indices = e.data;	
	applySearchResult(indices);
}

function applySearchResult(indices) {
	let elements = document.getElementsByTagName("li");
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
	let elements = document.getElementsByTagName("li");
	for (let element of elements) {
		element.style.display = 'list-item';
	}
}