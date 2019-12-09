#!/usr/bin/env node
// chrome-profile.js

/**
 * @desc select which `google chrome`s profile to launch using dmenu
 *
 * @author Kipras Melnikovas (kipras.org) <kipras@kipras.org>
 * Find this script in my dotfiles:
 * https://github.com/sarpik/voidrice/blob/master/.scripts/tools/chrome-profile.js
 *
 * @license GPLv3
 * `chrome-profile.js` is free/libre software, licensed under the GPLv3 license terms
 */

console.log = function() {}; // disable console.log in production (comment out when debugging)

// you might want to modify this if you launch google-chrome differently
const googleChromeLaunchCmd = "google-chrome-stable";

const os = require("os");
const fs = require("fs");
const path = require("path");
const child_process = require("child_process");

const homeDir = os.homedir();
const filePath = path.join(homeDir, ".config", "google-chrome", "Local State");

const toQuotes = (someString) => '"' + someString + '"'; // `foo` => `"foo"`

// async solution. doesn't work.
// let rawFileContent;
// fs.readFile(filePath, { encoding: "utf-8" }, (err, data) => {
// 	if (err) throw err;

// 	console.log("data", data);
// 	rawFileContent = data;
// });

const rawFileContent = fs.readFileSync(filePath, { encoding: "utf-8" });
const jsonFileContent = JSON.parse(rawFileContent);

const profiles = jsonFileContent.profile.info_cache;

let profileNamesAndKeys = {};
let namesStrForDmenu = "";

for (const key in profiles) {
	const { name } = profiles[key];
	console.log(toQuotes(key), toQuotes(name));

	/**
	 * remap `key => value` to `value => key`
	 * this is used to display actual names of user's profiles in `dmenu`
	 * like `John Smith` instead of the profiles' id's like `Default` or `Profile 1`
	 */
	profileNamesAndKeys[name] = key;

	/**
	 * `dmenu` takes strings, divided by newlines,
	 * gives the user a selection prompt for one of these strings,
	 * and returns the string on selection.
	 *
	 * i.e. `printf "foo \n bar \n foobar"` -> displays 3 selections: "foo" "bar" "foobar"
	 * on selection returns the selected name.
	 */
	namesStrForDmenu += name + "\n";
}

namesStrForDmenu = toQuotes(namesStrForDmenu); // `foo\nbar\nfoobar` => `"foo\nbar\nfoobar"`

console.log("profileNamesAndKeys", profileNamesAndKeys);
console.log("namesStrForDmenu", namesStrForDmenu);

/**
 * `-i` option for `dmenu` makes it match options case-insensitively
 */
child_process.exec(`printf ${namesStrForDmenu} | dmenu -i`, (error, stdout, stderr) => {
	let errored = false;

	if (stderr) {
		console.error(`exec dmenu stderr: \n${stderr}`);
		errored = true;
	}

	if (error) {
		console.error(`exec dmenu error: \n${error}`);
		errored = true;
	}

	if (!stdout) {
		console.error("dmenu error: selection empty");
		errored = true;
	}

	if (errored) {
		return;
	}

	/**
	 * We needed newlines for `dmenu`, remember?
	 * Now we gotta remove them from the selected option!
	 */
	const selectedOption = stdout.replace("\n", "");

	/**
	 * We swapped `key <=> value` pairs to provide better UX, remember?
	 * Now we just get back the actual profile name
	 * from the `profileNamesAndKeys` object
	 * by using the `selectedOption`
	 *
	 * And then put it into quotes
	 */
	let profileToLaunch = profileNamesAndKeys[selectedOption];
	profileToLaunch = toQuotes(profileToLaunch);

	console.log("stdout (quoted)", stdout);
	console.log("profileToLaunch (quoted)", profileToLaunch);

	/**
	 * launch yet another child process & use exec.
	 *
	 * this time we check if the user has the `googleChromeLaunchCmd` command.
	 * if it exists, then we proceed to launch `chrome` with the selected profile!
	 */
	child_process.exec(
		`command -v ${googleChromeLaunchCmd} && ${googleChromeLaunchCmd} --profile-directory=${profileToLaunch}`,
		(error, stdout, stderr) => {
			let errored = false;

			/**
			 * note: the error
			 * `[<dddd>:<dddd>:<dddd>/<dddddd>.<dddddd>:ERROR:browser_process_sub_thread.cc(217)] Waited <d> ms for network service`
			 * is common and is not an issue
			 */
			if (stderr) {
				console.error(`exec ${googleChromeLaunchCmd} stderr: \n${stderr}`);
				errored = true;
			}

			if (error) {
				console.error(`exec ${googleChromeLaunchCmd} error: \n${error}`);
				errored = true;
			}

			if (errored) {
				return;
			}
		}
	);
});
