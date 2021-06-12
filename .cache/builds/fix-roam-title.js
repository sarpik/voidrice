/**
 * usage:
 *
 * nativefier "https://roamresearch.com/#/app/GRAPH_NAME" --name roam --inject ./fix-roam-title.js
 *
 */

function changeTitle() {
	document.querySelector("title").textContent = "dropdown_roam";
}

let called = false;

function observeAndChangeTitle() {
	if (called) return;
	called = true;

	const targetNode = document.querySelector("title");
	const config = { attributes: true, childList: true, subtree: true };
	const callback = function(_mutationsList, _observer) {
		changeTitle();
	};

	const observer = new MutationObserver(callback);
	observer.observe(targetNode, config);
}

document.addEventListener("DOMContentLoaded", () => {
	observeAndChangeTitle();
});

if (document.readyState === "interactive") {
	observeAndChangeTitle();
}

