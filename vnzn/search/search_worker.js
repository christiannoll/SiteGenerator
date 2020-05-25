importScripts('searchIndex.js');

var worker;

onmessage = function(e) {
	var data = e.data;
	var msg = data[0];
	if (msg === "index"){
		worker = new SearchWorker();
		//worker.test();
	}
	else if (msg === "search"){
		worker.search(data[1]);
	}
}

function SearchWorker() {
	this.searchIndex = getSearchIndex();
}


SearchWorker.prototype.search = function(searchStr){
	var foundIndices = new Array();
	
	if (searchStr.length > 2){
		var tokens = this.splitInTokens(searchStr);
		for (let token of tokens){
			var len = token.length;
			var stop = false;
			for (var i = 0; i <= len-3; i++){
  				var part = token.slice(i, i+3).toLowerCase();
  				var indices = this.searchIndex.get(part);
  				if (indices !== undefined){
  					if (foundIndices.length === 0){
  						for (let index of indices){
  							foundIndices.push(index);
  						}
  					}
  					else {
  						var matchedIndices = new Array();
  						for (let index of indices){
  							if (foundIndices.includes(index)){
  								matchedIndices.push(index);
  							}
  						}
  						foundIndices = [];
  						if (matchedIndices.length > 0){
  							foundIndices.push.apply(foundIndices, matchedIndices);
  						}
  					}
  				}
  				else {
  					foundIndices = [];
  				}
  				
  				if (foundIndices.length === 0){
  					stop = true;
  					break;
  				}
  			}
  			if (stop){
  				break;
  			}
  		}
	}
	
	//console.log(foundIndices);
  	postMessage(foundIndices);
}

SearchWorker.prototype.test = function(){
	var indices = this.searchIndex.get("ech");
	console.log(indices);
}

SearchWorker.prototype.splitInTokens = function(str){
	return str.split(/[ \"\"\",:'!\.\(\)\[\]\/\+\*\?]/);
}
