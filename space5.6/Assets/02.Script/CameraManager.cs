using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraManager : MonoBehaviour {

	public GameObject fadePanel;

	public GameObject planetRing;
	public GameObject planetGlow;
	public GameObject planet;
	public GameObject SmokeParticle;
	public GameObject surface;

	public GameObject warp;

	public float fadeSpeed = 1.0f;
	SpriteRenderer spR;

	bool flag;
	// Use this for initialization
	void Start () {
		spR = fadePanel.GetComponent<SpriteRenderer> ();
		flag = false;
		SmokeParticle.GetComponent<ParticleSystem> ().Stop ();
	}

	void Update () {
		if (Input.GetKey (KeyCode.Alpha8)) {
			StartCoroutine(FadeTo(1.0f, 3.0f));
			StartCoroutine(TimerToFadeToBlack(3.0f));
		}
		if (Input.GetKey (KeyCode.Alpha9)) {
			//StartCoroutine (ShowSurface (1.0f));

			//StartCoroutine(FadeTo(0.0f, 5.0f));
			CameraShake.isShakeNow= true;
		}

		if (ObjControl.distance <=20000.0f && flag == false && MultiShooter.isAlienDestroyed) {			
				StartCoroutine (DustOperator(0.0f));
			if (ObjControl.distance <= 10000.0f) {
				flag = true;
				Debug.Log ("why not?");
				StartCoroutine(FadeTo(1.0f,0.5f));
				StartCoroutine (DustOperator (1.0f));
				StartCoroutine (TimerToFadeToBlack (1.5f));
				//StartCoroutine(FadeTo(0.0f, 3.0f));
				StartCoroutine (ShowSurface (3.1f));

			}
			//StartCoroutine(FadeTo(1.0f, 5.0f));
		
		//	StartCoroutine(TimerToFadeToBlack(3.0f));
		//	StartCoroutine(TimerWaitForSeconds (4.8f));
		}

	}
	IEnumerator ShowSurface(float aTime){
		yield return new WaitForSeconds (aTime);
		StartCoroutine(FadeTo(0.0f, 1.5f));
		surface.SetActive (true);
		CameraShake.isShakeNow= true;
		StartCoroutine (DisableWarpEffect (0.3f));
	}
	IEnumerator DisableWarpEffect(float time){
		yield return new WaitForSeconds (time);
		warp.GetComponent<ParticleSystem> ().Stop ();
	}

	IEnumerator SpriteTransparent(float aValue, float atime){
		float alpha = spR.color.a;
		for (float t = 0.0f; t < 1.0f; t += Time.deltaTime / atime) {
			Color newColor = new Color (1, 1, 1, Mathf.Lerp (alpha, aValue, t));
			spR.color = newColor;
			yield return null;
		}

	}

	IEnumerator TimerToFadeToBlack(float time){
		yield return new WaitForSeconds (time);
		FadeToBlack ();

	}
	/*
	IEnumerator FadetoBlack_TEST(float atime){
		Material mat = new Material (Shader.Find ("Exo-Planets/Rings"));
		var color = mat.color;

		for (float t = 0; t < 1.0; t += Time.deltaTime / atime) {
			mat.SetColor ("_node_8903", Color.black);
			planetRing.GetComponent<Renderer> ().material.SetColor ("_node_8903", Color.black);
		}
	}
	*/

	void FadeToBlack(){
		Material mat_Ring = new Material (Shader.Find ("Exo-Planets/Rings"));
	//	Material mat_Light = new Material(Shader.Find("Custom/Atmosphere ASE"));
	//	mat_Light.SetColor ("_Atmospherecolor", Color.black);
		mat_Ring.SetColor ("_node_8903", Color.black);
	//	planetGlow.GetComponent<Renderer> ().material.SetColor ("_Atmospherecolor", Color.black);
		planetRing.GetComponent<Renderer> ().material.SetColor ("_node_8903", Color.black);
		if (planet.activeSelf) {
			planet.SetActive (false);
		}
	}

	IEnumerator FadeTo(float aValue, float aTime){
		float alpha = spR.color.a;
		for (float t = 0.0f; t < 1.0f; t += Time.deltaTime / aTime) {
			Color newColor = new Color (1, 1, 1, Mathf.Lerp (alpha, aValue, t));
			spR.color = newColor;
			yield return null;
		}
	}

	IEnumerator TimerWaitForSeconds(float time){
		yield return new WaitForSeconds (time);
		StartCoroutine (ShowSurface (1.0f));

		StartCoroutine(FadeTo(0.0f, 5.0f));
	}
	bool dustFlag = false;
	IEnumerator DustOperator(float atime){
		yield return new WaitForSeconds (atime);
		if (dustFlag == false) {
			dustFlag = true;
			SmokeParticle.GetComponent<ParticleSystem> ().Play ();
		}

	}
	/*
	IEnumerator SmogEffect(){


	}

*/
	/*WHEN FADEOUT;;
	 * 1. FADE OUT RING  - check
	 * 2. FADE OUT PLANET ITSELF   - check
	 * 3. WHEN PLANET BLACK => DESTORY OR SETACTIVE (FALSE);   - check;
	 * 4. DURING FADEOUT, GENERATE SMOG
	 * 5. FADE IN THE SURFACE
	 * 
	 */



	/*	
	IEnumerator FadeIn(){
		do{
			FadeToBlack();
			if(spR.color.a >=0.95f){
				Debug.Log("Lets Bright again");
				yield break;
			}
			else{
				yield return null;
			}
		}while(true);
	}
	*/
}
