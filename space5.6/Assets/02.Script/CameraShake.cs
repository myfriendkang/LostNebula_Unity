using UnityEngine;
using System.Collections;

public class CameraShake : MonoBehaviour
{
	// Transform of the camera to shake. Grabs the gameObject's transform
	// if null.
	public Transform camTransform;

	// How long the object should shake for.
	public float shakeDuration = 0f;

	// Amplitude of the shake. A larger value shakes the camera harder.
	public float shakeAmount = 0.7f;
	public float decreaseFactor = 1.0f;
	static public bool isShakeNow;

	Vector3 originalPos;

	void Awake()
	{
		isShakeNow = false;
	}

	void OnEnable()
	{
		originalPos = camTransform.localPosition;
	}

	void Update()
	{
		if (isShakeNow == true) {
			if (shakeDuration > 0) { 
				originalPos = camTransform.localPosition;
				camTransform.localPosition = originalPos + Random.insideUnitSphere * shakeAmount;

				shakeDuration -= Time.deltaTime * decreaseFactor;
				shakeAmount -= Time.deltaTime * decreaseFactor;
			}
			else {
				shakeDuration = 0f;
				shakeAmount = 0f;
				camTransform.localPosition = originalPos;
			}


		} 

	}

}