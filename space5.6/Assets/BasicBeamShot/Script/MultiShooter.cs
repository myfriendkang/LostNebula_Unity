using UnityEngine;
using System.Collections;

public class MultiShooter : MonoBehaviour {

	public GameObject Shot1;
	public GameObject Shot2;
    public GameObject Wave;

	public GameObject explosive;
	public GameObject alienbody;
	public GameObject alienCannon;
	public float Disturbance = 0;

	public int ShotType = 0;

	private GameObject NowShot;
	ParticleSystem pS;

	public static bool isAlienDestroyed;
	public GameObject unityData;


	void Start () {
		NowShot = null;
		isAlienDestroyed = false;
		explosive.GetComponent<ParticleSystem> ().Stop ();
		pS = explosive.GetComponent<ParticleSystem> ();

	}

	void Update () {
		GameObject Bullet;

		if(Input.GetKeyDown(KeyCode.JoystickButton0) || Input.GetKeyDown(KeyCode.Space)) {

			if (unityData.GetComponent<Unity_interface> ().readyToShot) {
				//if(Input.GetKeyDown(KeyCode.Space)){
				Debug.Log ("heee");
				GameObject wav = (GameObject)Instantiate (Wave, this.transform.position, this.transform.rotation);
				wav.transform.Rotate (Vector3.left, 90.0f);
				wav.GetComponent<BeamWave> ().col = this.GetComponent<BeamParam> ().BeamColor;

				Bullet = Shot2;
				//Fire
				NowShot = (GameObject)Instantiate (Bullet, this.transform.position, this.transform.rotation);

				BeamParam bp = this.GetComponent<BeamParam> ();
				if (NowShot.GetComponent<BeamParam> ().bGero)
					NowShot.transform.parent = transform;

				Vector3 s = new Vector3 (bp.Scale, bp.Scale, bp.Scale);

				NowShot.transform.localScale = s;
				NowShot.GetComponent<BeamParam> ().SetBeamParam (bp);

				StartCoroutine (LaserTimer (4.5f));
				StartCoroutine (AlienExplosive (5.5f));
			}
		}
		if (Input.GetKeyDown (KeyCode.Space)) {
			if (unityData.GetComponent<Unity_interface> ().readyToShot) {
				//if(Input.GetKeyDown(KeyCode.Space)){
				Debug.Log ("heee");
				GameObject wav = (GameObject)Instantiate (Wave, this.transform.position, this.transform.rotation);
				wav.transform.Rotate (Vector3.left, 90.0f);
				wav.GetComponent<BeamWave> ().col = this.GetComponent<BeamParam> ().BeamColor;

				Bullet = Shot2;
				//Fire
				NowShot = (GameObject)Instantiate (Bullet, this.transform.position, this.transform.rotation);

				BeamParam bp = this.GetComponent<BeamParam> ();
				if (NowShot.GetComponent<BeamParam> ().bGero)
					NowShot.transform.parent = transform;

				Vector3 s = new Vector3 (bp.Scale, bp.Scale, bp.Scale);

				NowShot.transform.localScale = s;
				NowShot.GetComponent<BeamParam> ().SetBeamParam (bp);

				StartCoroutine (LaserTimer (4.5f));
				StartCoroutine (AlienExplosive (5.5f));
			}
		}
	}

	IEnumerator LaserTimer(float time){
		yield return new WaitForSeconds (time);
		if(NowShot != null)
		{
			NowShot.GetComponent<BeamParam>().bEnd = true;
		}
	}

	IEnumerator AlienExplosive(float time){
		var ma = pS.main;
		ma.simulationSpeed = 0.25f;
		pS.Play ();
		StartCoroutine (DisableParticle (9.2f));
		yield return new WaitForSeconds (time);
		isAlienDestroyed = true;
		alienbody.GetComponent<MeshRenderer> ().enabled = false;
		alienCannon.GetComponent<MeshRenderer> ().enabled = false;

	}

	IEnumerator DisableParticle(float time){
		yield return new WaitForSeconds (time);
		if (pS.isPlaying) {
			Debug.Log ("Hey Stop that shit");
			explosive.SetActive (false);
		}
	}
}
