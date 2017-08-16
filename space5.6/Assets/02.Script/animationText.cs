using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class animationText : MonoBehaviour {

	public Text textArea;
	public string [] strings;
	public float speed = 0.1f;

	int stringIndex = 0;
	int charIndex	= 0;
	int lineCount = 0;
	// Use this for initialization
	void Start () {
		StartCoroutine (DisplayTimer ());
	}

	// Update is called once per frame
	void Update () {
		
	}

	IEnumerator DisplayTimer(){
		while (1 == 1) {
			yield return new WaitForSeconds (speed);
			if(charIndex > strings[stringIndex].Length){
				continue;
			}
			textArea.text = strings [stringIndex].Substring (0, charIndex);
			charIndex++;

		}
	}


}
