using UnityEngine;
using System.Collections;

public class textController : MonoBehaviour {

	public float delay = -1.0f;
	public string fullText;
	private string currenText = "";
	float temp =12.3f;
	float x;

	// Use this for initialization
	void Start () {
		
		StartCoroutine (ShowText ());
		//x = this.gameObject.GetComponent<RectTransform> ().offsetMax.x;
		//InvokeRepeating ("Timer", 3, 1.5f);
	}

	void Update(){
		//x = this.gameObject.GetComponent<RectTransform> ().offsetMax.x;
	}

	IEnumerator ShowText(){
		for (int i = 0; i < fullText.Length; i++) {
			currenText = fullText.Substring (0, i);
			//this.GetComponent
			//this.GetComponent<> ().text = currenText;

			yield return new WaitForSeconds (delay);

		}
	}
	/*
	void Timer(){
		this.gameObject.GetComponent<RectTransform> ().offsetMax = new Vector2(x ,temp);
		//this.gameObject.GetComponent<RectTransform> ().offsetMax = new Vector2 (this.gameObject.GetComponent<RectTransform>().rect.right, temp);
		temp += 12.3f;
	}
	*/


}
