___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "WebToffee CMP",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "The WebToffee CMP makes your website’s use of cookies compliant with the global data privacy laws such as the GDPR, ePrivacy, CCPA, and LGPD. Visit www.webtoffee.com to learn more about WebToffee.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "defaultSettings",
    "displayName": "Default Consent Settings",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "PARAM_TABLE",
        "name": "regionSettings",
        "paramTableColumns": [
          {
            "param": {
              "type": "SELECT",
              "name": "analytics",
              "displayName": "Analytics Cookies",
              "macrosInSelect": true,
              "selectItems": [
                {
                  "value": "granted",
                  "displayValue": "Enabled"
                },
                {
                  "value": "denied",
                  "displayValue": "Disabled"
                }
              ],
              "simpleValueType": true
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "SELECT",
              "name": "advertisement",
              "displayName": "Advertisement Cookies",
              "macrosInSelect": true,
              "selectItems": [
                {
                  "value": "granted",
                  "displayValue": "Enabled"
                },
                {
                  "value": "denied",
                  "displayValue": "Disabled"
                }
              ],
              "simpleValueType": true
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "SELECT",
              "name": "functional",
              "displayName": "Functional Cookies",
              "macrosInSelect": true,
              "selectItems": [
                {
                  "value": "granted",
                  "displayValue": "Enabled"
                },
                {
                  "value": "denied",
                  "displayValue": "Disabled"
                }
              ],
              "simpleValueType": true
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "SELECT",
              "name": "security",
              "displayName": "Necessary Cookies",
              "macrosInSelect": true,
              "selectItems": [
                {
                  "value": "granted",
                  "displayValue": "Enabled"
                },
                {
                  "value": "denied",
                  "displayValue": "Disabled"
                }
              ],
              "simpleValueType": true
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "SELECT",
              "name": "adUserData",
              "displayName": "Share user data with Google",
              "macrosInSelect": true,
              "selectItems": [
                {
                  "value": "granted",
                  "displayValue": "Enabled"
                },
                {
                  "value": "denied",
                  "displayValue": "Disabled"
                }
              ],
              "simpleValueType": true
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "SELECT",
              "name": "adPersonal",
              "displayName": "Use data for ads personalization",
              "macrosInSelect": true,
              "selectItems": [
                {
                  "value": "granted",
                  "displayValue": "Enabled"
                },
                {
                  "value": "denied",
                  "displayValue": "Disabled"
                }
              ],
              "simpleValueType": true
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "TEXT",
              "name": "regions",
              "displayName": "Regions",
              "simpleValueType": true,
              "help": "Specify a comma-separated list of \u003ca href\u003d\"https://en.wikipedia.org/wiki/ISO_3166-2\"\u003eregions\u003c/a\u003e for which you want to apply this setting. If you specify All, the setting will be applied to all users.",
              "defaultValue": "All"
            },
            "isUnique": false
          }
        ],
        "newRowButtonText": "Add Setting"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "otherSettings",
    "displayName": "Other Settings",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "TEXT",
        "name": "waitForTime",
        "displayName": "Wait for update",
        "simpleValueType": true,
        "valueUnit": "milliseconds",
        "help": "Set the number of milliseconds to wait before firing tags waiting for consent.",
        "defaultValue": 2000,
        "valueValidators": [
          {
            "type": "POSITIVE_NUMBER"
          },
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "urlPassThrough",
        "checkboxText": "Pass ad click information through URLs",
        "simpleValueType": true,
        "help": "Check this option if you would like internal links to include advertising identifiers (such as gclid, dclid, gclsrc, and _gl) in their URLs while waiting for consent to be granted."
      },
      {
        "type": "CHECKBOX",
        "name": "adsRedaction",
        "checkboxText": "Redact ads data",
        "simpleValueType": true,
        "help": "When this option is checked and the default consent state of \"Advertisement Cookies\" is disabled, Google\u0027s advertising tags will remove all advertising identifiers from the requests, and route the traffic through domains that do not use cookies."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const setDefaultConsentState = require("setDefaultConsentState");
const gtagSet = require("gtagSet");
const getCookieValues = require("getCookieValues");
const updateConsentState = require("updateConsentState");
const log = require('logToConsole');
function getConsentStateForCategory(categoryConsent) {
  return categoryConsent === "yes" ? "granted" : "denied";
}

// Set default GTM settings
gtagSet({
  ads_data_redaction: true,
  url_passthrough: true,
  "developer_id.dZDk4Nz": true,
});

// Set default consent state (all denied except security)
setDefaultConsentState({
  ad_storage: "denied",
  analytics_storage: "denied",
  functionality_storage: "denied",
  personalization_storage: "denied",
  security_storage: "granted",
  ad_user_data: "denied",
  ad_personalization: "denied"
});

// Get wt_consent cookie value
const consentString = getCookieValues("wt_consent", false)[0];
if (consentString && typeof consentString === "string") {
  // Parse cookie values
  const cookieValues = consentString.split(",").reduce(function(acc, curr) {
    var parts = curr.split(":");
    var key = parts[0].trim();
    var value = parts[1];
    acc[key] = value;
    return acc;
  }, {});
  // Update consent state based on cookie values
  updateConsentState({
    ad_storage: getConsentStateForCategory(cookieValues.advertisement || "no"),
    analytics_storage: getConsentStateForCategory(cookieValues.analytics || "no"),
    functionality_storage: getConsentStateForCategory(cookieValues.functional || "no"),
    personalization_storage: getConsentStateForCategory(cookieValues.functional || "no"),
    security_storage: getConsentStateForCategory(cookieValues.necessary || "yes"),
    ad_user_data: getConsentStateForCategory(cookieValues.advertisement || "no"),
    ad_personalization: getConsentStateForCategory(cookieValues.advertisement || "no")
  });
}

// Success callback
data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "write_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "ads_data_redaction"
              },
              {
                "type": 1,
                "string": "url_passthrough"
              },
              {
                "type": 1,
                "string": "developer_id.dZDk4Nz"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "wt_consent"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functional_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "security_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "wait_for_update"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []
setup: ''


___NOTES___

Created on 10/06/2025, 09:28:28


