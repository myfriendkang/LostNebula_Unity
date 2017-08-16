using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TypeWriter : MonoBehaviour {

	public float delay = -1.0f;
	public string fullText;
	private string currenText = "";
	float temp =12.3f;
	float x;
	public static int count = 2 ;
	public static bool displayText;
	public static bool letsReset;
	// Use this for initialization
	void Start () {
		displayText = false;
		letsReset = false;
		//x = this.gameObject.GetComponent<RectTransform> ().offsetMax.x;
		//InvokeRepeating ("Timer", 3, 1.5f);
	}

	void Update(){
		if (displayText && count>0) {
			displayText = false;

			StartCoroutine (ShowText ());

		}
		if (count == 0) {
			Debug.Log ("letsrREsst!");
			letsReset = true;
		}
		//x = this.gameObject.GetComponent<RectTransform> ().offsetMax.x;
	}

	IEnumerator ShowText(){
		
		for (int i = 0; i < fullText.Length; i++) {
			currenText = fullText.Substring (0, i);
			this.gameObject.GetComponent<TextMesh> ().text = currenText;
			yield return new WaitForSeconds (delay);
	
		}
		count -= 1;
		this.gameObject.GetComponent<TextMesh> ().text = " ";
		displayText = true;
	}
}
