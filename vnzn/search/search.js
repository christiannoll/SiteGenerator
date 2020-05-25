var worker = new Worker("search_worker.js");

function startSearchWorker(){
	worker.postMessage(["index", 0]);
}

function search(searchStr){
	worker.postMessage(["search", searchStr]);
}

worker.onmessage = function(e){
	var indices = e.data;
	//entriesDoc.writeSearchResults(indices);
	console.log(indices);
}