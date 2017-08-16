using UnityEngine;
using System.Collections;

public class MouseTgt : MonoBehaviour {

	public Transform alienTarget;
	//public bool isAlienApproach;
	// Use this for initialization
	void Start () {
		//isAlienApproach = false;
	}
	
	// Update is called once per frame
	void Update () {
		//if (isAlienApproach) {
			transform.LookAt (alienTarget);
			transform.eulerAngles = new Vector3 (transform.eulerAngles.x, transform.eulerAngles.y, transform.eulerAngles.z);

		//}


		//Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
		//Vector3 dir= ray.direction.normalized;

		//transform.LookAt(transform.position+dir*16.0f);
	}
}
