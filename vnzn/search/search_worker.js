importScripts('searchIndex.js');

var worker;

onmessage = function(e) {
	let data = e.data;
	let msg = data[0];
	if (msg === "index"){
		worker = new SearchWorker();
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
		let tokens = this.splitInTokens(searchStr);
		for (let token of tokens){
			let len = token.length;
			var stop = false;
			for (var i = 0; i <= len-3; i++){
  				let part = token.slice(i, i+3).toLowerCase();
  				let indices = this.searchIndex.get(part);
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
	
  	postMessage(foundIndices);
}

SearchWorker.prototype.splitInTokens = function(str){
	return str.split(/[ \"\"\",:'!\.\(\)\[\]\/\+\*\?]/);
}
