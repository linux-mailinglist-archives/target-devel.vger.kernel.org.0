Return-Path: <target-devel+bounces-13-lists+target-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AC87FA981
	for <lists+target-devel@lfdr.de>; Mon, 27 Nov 2023 20:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55A2B20F33
	for <lists+target-devel@lfdr.de>; Mon, 27 Nov 2023 19:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E16F37163;
	Mon, 27 Nov 2023 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9qeZx1/"
X-Original-To: target-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EA5D4D
	for <target-devel@vger.kernel.org>; Mon, 27 Nov 2023 11:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701111702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gO0T4YIb/aiZyC/La5KMLP70bNSf/D+FzfSC/oD3+pQ=;
	b=P9qeZx1/Q8PaWFMqvOL6wZHnPqD8VOlLSJ8DXM1dHKcn0D2amV/eJEF+t+MYHp3zt1i2g5
	b1P2AH/ryBtmYhPUD7b8IOtxZUtL6MRkpl5z6W+X0uy7/jJr6ET7J3Ljjt7JaPlyqziLAj
	gvc5/mG3su0r4VubWCOJfCY3mH/ExaU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-oPNDh7B1NNGY2yHT_qR-mQ-1; Mon, 27 Nov 2023 14:01:41 -0500
X-MC-Unique: oPNDh7B1NNGY2yHT_qR-mQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67804869762so54984256d6.0
        for <target-devel@vger.kernel.org>; Mon, 27 Nov 2023 11:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111700; x=1701716500;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gO0T4YIb/aiZyC/La5KMLP70bNSf/D+FzfSC/oD3+pQ=;
        b=mq++NDucL+L5Te2RPhDiAc2nS7a+HWy21DVJ78JcVciVJ57QWpJOnOP00nctnhBRrb
         wQrtgjWi/WCw17dac4PFPwdehRtkQ81PO/9AMb6mXBQ/hMogvqgxYc5vgWIc2Ftj+ChG
         hMM6v69g/8c4oP+n1+Gua3iqIWX6yON13t6jf6Jnl0LbXSLDuR4nc/aQnYATnjJIL6f5
         mlRAiO9ZqHE4Rlpjok7JCHDNrZGqbFc+WbbrgKM5DODlRUiSQC7Jzxxc82TOPcGHnnZk
         y+h+TcqOKJvDSlYP5Kstf3I4JxqusXkNLFwZKRV69H5uPcDupdoZhDihR+ImEmjKogv4
         EWpw==
X-Gm-Message-State: AOJu0YzkJzcE603UBS7uuscnSW4HDQcMzzKhMGl+xRlgAIXU1aiY3yN0
	82RADhhuLH1LqHj91w6PMdV+wya3HmPQbLkkVsTUhgRig5rzJDeg/g/juas8IfWHGuEPh+dHb3x
	DQspYaHOH4WUpIqyAroVP/cIbK3bgERJb
X-Received: by 2002:a05:6214:892:b0:67a:3efb:df5f with SMTP id cz18-20020a056214089200b0067a3efbdf5fmr5563791qvb.0.1701111700197;
        Mon, 27 Nov 2023 11:01:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHLH4rgLgsmN5tGO2pWmQzu52awRS6bcFCJWOeTNESTpDcYEl0kKZtZ7+GtPWGiFENKGDLkA==
X-Received: by 2002:a05:6214:892:b0:67a:3efb:df5f with SMTP id cz18-20020a056214089200b0067a3efbdf5fmr5563756qvb.0.1701111699880;
        Mon, 27 Nov 2023 11:01:39 -0800 (PST)
Received: from ?IPv6:2600:6c64:4e7f:603b:7f10:16a0:5672:9abf? ([2600:6c64:4e7f:603b:7f10:16a0:5672:9abf])
        by smtp.gmail.com with ESMTPSA id 10-20020ad45baa000000b0067a21a7397bsm2997914qvq.12.2023.11.27.11.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:01:39 -0800 (PST)
Message-ID: <c15d1412826033922009a4475587b028a67f9abc.camel@redhat.com>
Subject: Re: Possible Bug? LIO does not support SCSI commands with Immediate
 Bit Set?
From: Laurence Oberman <loberman@redhat.com>
To: Mike Christie <michael.christie@oracle.com>, Hannes Reinecke
 <hare@suse.de>,  Lee Duncan <lduncan@suse.com>, target-devel
 <target-devel@vger.kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi
	 <linux-scsi@vger.kernel.org>, Chris Leech <cleech@redhat.com>
Date: Mon, 27 Nov 2023 14:01:38 -0500
In-Reply-To: <5301e42d-7fad-49e1-8ebd-7db569416974@oracle.com>
References: <31851279-0884-48ba-8c4b-7d6147e59508@suse.com>
	 <00eb0928-5691-4e85-a923-de9c4934856c@suse.de>
	 <5301e42d-7fad-49e1-8ebd-7db569416974@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: target-devel@vger.kernel.org
List-Id: <target-devel.vger.kernel.org>
List-Subscribe: <mailto:target-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:target-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gU3VuLCAyMDIzLTExLTI2IGF0IDE4OjM5IC0wNjAwLCBNaWtlIENocmlzdGllIHdyb3RlOgo+
IE9uIDExLzI2LzIzIDY6MDEgQU0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiA+IE9uIDExLzI1
LzIzIDE5OjI4LCBMZWUgRHVuY2FuIHdyb3RlOgo+ID4gPiBIaSBNYXJ0aW4vbGlzdDoKPiA+ID4g
Cj4gPiA+IEkgYW0gdHJ5aW5nIHRvIHRyYWNrIGRvd24gYW4gaXNzdWUgSSBhbSBzZWVpbmcgd2hl
biB0cnlpbmcgdG8KPiA+ID4gYm9vdCB1c2luZyBpU0NTSSByb290IHVzaW5nIHRoZSBmYXN0bGlu
cSBxZWRpIGNvbnZlcmdlZCBuZXR3b3JrCj4gPiA+IGFkYXB0ZXIgaW5pdGlhdG9yIGFuZCBhbiBM
SU8gdGFyZ2V0Lgo+ID4gPiAKPiA+ID4gSW4gdGhpcyBjb25maWd1cmF0aW9uLCBidXQgdXNpbmcg
YSBub24tTElPIChoYXJkd2FyZSkgaVNDU0kKPiA+ID4gdGFyZ2V0LCBldmVyeXRoaW5nICJqdXN0
IHdvcmtzIi4gQnV0IHdoZW4gSSBzd2l0Y2ggdG8gdXNpbmcgYW4KPiA+ID4gTElPIHNvZnR3YXJl
IHRhcmdldCwgSSBnZXQgdGhpcyBlcnJvciB3aGVuIGJvb3Rpbmc6Cj4gPiA+IAo+ID4gPiA+IDIw
MjMtMDktMjBUMTQ6MTA6MzIuODM1MzU4LTA1MDAgd29ya2VyNSBrZXJuZWw6IElsbGVnYWxseSBz
ZXQKPiA+ID4gPiBJbW1lZGlhdGUgQml0IGluIGlTQ1NJIEluaXRpYXRvciBTY3NpIENvbW1hbmQg
UERVLgo+ID4gPiA+IC4uLiA+IDIwMjMtMDktMjBUMTQ6MTA6MzIuODM1NDIyLTA1MDAgd29ya2Vy
NSBrZXJuZWw6IEdvdAo+ID4gPiA+IHVua25vd24gaVNDU0kgCj4gPiA+IE9wQ29kZTogMHg1Mgo+
ID4gPiAKPiA+ID4gSXQgbG9va3MgbGlrZSB0aGUgZmFzdGxpbnEgYWRhcHRlciBpcyBzZW5kaW5n
IGEgU0NTSSB3cml0ZSAoMHgxMikKPiA+ID4gd2l0aCB0aGUgSW1tZWRpYXRlIGJpdCBzZXQgKDB4
NDApLgo+ID4gPiAKPiA+ID4gVGhlIGNvZGUgaW4gaXNjc2lfdGFyZ2V0LmM6aXNjc2l0X3NldHVw
X3Njc2lfY21kKCk6IGxvb2tzIGxpa2UKPiA+ID4gdGhpczoKPiA+ID4gCj4gPiA+ID4gwqDCoMKg
wqBpZiAoaGRyLT5vcGNvZGUgJiBJU0NTSV9PUF9JTU1FRElBVEUpIHsKPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoCBwcl9lcnIoIklsbGVnYWxseSBzZXQgSW1tZWRpYXRlIEJpdCBpbiBpU0NTSSBJbml0
aWF0b3IiCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIgU2NzaSBDb21t
YW5kIFBEVS5cbiIpOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBpc2NzaXRfYWRkX3Jl
amVjdF9jbWQoY21kLAo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBJU0NTSV9SRUFTT05fQk9PS01BUktfSU5WQUxJRCwgYnVmKTsKPiA+ID4g
PiDCoMKgwqDCoH0KPiA+ID4gPiAKPiA+ID4gCj4gPiA+IEJ1dCBJIGxvb2tlZCBhdCByZmMzNzIw
LCBhbmQgaXQgbG9va3MgbGlrZSBTQ1NJIFBEVXMgY2FuIGhhdmUgdGhlCj4gPiA+IEltbWVkaWF0
ZSBCaXQgc2V0Ogo+ID4gPiAKPiA+ID4gPiAxMC4zLsKgIFNDU0kgQ29tbWFuZAo+ID4gPiA+IMKg
wqAgVGhlIGZvcm1hdCBvZiB0aGUgU0NTSSBDb21tYW5kIFBEVSBpczoKPiA+ID4gPiDCoMKgIEJ5
dGUvwqDCoMKgwqAgMMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgIDHCoMKgwqDCoMKgwqAgfMKg
wqDCoMKgwqDCoCAywqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqAKPiA+ID4gPiAzwqDCoMKgwqDC
oMKgIHwKPiA+ID4gPiDCoMKgwqDCoMKgIC/CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+
ID4gPiA+IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiA+ID4gPiDCoMKgwqDCoCB8
MCAxIDIgMyA0IDUgNiA3fDAgMSAyIDMgNCA1IDYgN3wwIDEgMiAzIDQgNSA2IDd8MCAxIDIgMyA0
Cj4gPiA+ID4gNSA2IDd8Cj4gPiA+ID4gwqDCoMKgwqAgKy0tLS0tLS0tLS0tLS0tLSstLS0tLS0t
LS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLQo+ID4gPiA+IC0tLS0tLSsKPiA+ID4g
PiDCoMKgwqAgMHwufEl8IDB4MDHCoMKgwqDCoMKgIHxGfFJ8V3wuIC58QVRUUiB8Cj4gPiA+ID4g
UmVzZXJ2ZWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfAo+ID4g
PiA+IMKgwqDCoMKgICstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0t
LS0tLSstLS0tLS0tLS0KPiA+ID4gPiAtLS0tLS0rCj4gPiA+ID4gwqDCoMKgIDR8VG90YWxBSFNM
ZW5ndGggfAo+ID4gPiA+IERhdGFTZWdtZW50TGVuZ3RowqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfAo+ID4gPiA+IMKgwqDCoMKgICstLS0t
LS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0KPiA+
ID4gPiAtLS0tLS0rCj4gPiA+ID4gwqDCoMKgIDh8IExvZ2ljYWwgVW5pdCBOdW1iZXIKPiA+ID4g
PiAoTFVOKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gPiA+ID4gwqDCoMKgwqAKPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoAo+ID4gPiA+ICsKPiA+ID4gPiDCoMKgCj4gPiA+ID4gMTJ8wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4gwqDC
oCB8Cj4gPiA+ID4gwqDCoMKgwqAgKy0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rLS0t
LS0tLS0tLS0tLS0tKy0tLS0tLS0tLQo+ID4gPiA+IC0tLS0tLSsKPiA+ID4gPiAuLi4KPiA+ID4g
Cj4gPiA+IFdoZXJlICJJIiBpcyB0aGUgaW1tZWRpYXRlIGJpdC4KPiA+ID4gCj4gPiA+IEZyYW5r
bHksIEknbSBuZXZlciBzdXJlIEkgcmVhZCB0aGUgU1BFQyBjb3JyZWN0bHksIHNvIEknbSBub3QK
PiA+ID4gc3VyZSBpZiBJJ20gbWlzdGFrZW4gaGVyZSwgYnV0IGl0IGxvb2tzIGxpa2UgTElPIGRv
ZXMgbm90IGFsbG93Cj4gPiA+IHRoZSBJbW1lZGlhdGUgYml0IChhbmQgaGVuY2UgSW1tZWRpYXRl
IGRhdGEpLCBldmVuIHRob3VnaCB0aGUKPiA+ID4gU1BFQyBkb2VzIGFsbG93IGl0LiBCdXQgaXQg
YWxzbyBsb29rcyBsaWtlLCBkdXJpbmcgbmVnb3RpYXRpb24KPiA+ID4gcGhhc2UsIExJTyBuZWdv
dGlhdGVzIEltbWVkaWF0ZURhdGEgbGlrZSBhbnkgb3RoZXIgcGFyYW1ldGVyLAo+ID4gPiBhbGxv
d2luZyAiWUVTIi4KPiA+ID4gCj4gPiA+IEluIG91ciB0ZXN0aW5nLCBpZiB3ZSBzZXQgSW1tZWRp
YXRlRGF0YT1ObyBpbiB0aGUgdGFyZ2V0LCB0aGVuCj4gPiA+IG91ciBwcm9ibGVtIGdvZXMgYXdh
eSwgaS5lLiB3ZSBjYW4gbm93IGJvb3QgZnJvbSBhbiBMSU8gdGFyZ2V0Lgo+ID4gPiBUaGlzIGlz
IGJlY2F1c2UgSW1tZWRpYXRlIERhdGEgaXMgbmVnb3RpYXRlZCBvZmYsIG9mIGNvdXJzZS4KPiA+
ID4gCj4gPiA+IElzIHRoaXMgYSBidWcsIG9yIGlzIHRoaXMgYWRhcHRlciBkb2luZyBzb21ldGhp
bmcgd3Jvbmc/IEkgd291bGQKPiA+ID4gYXBwcmVjaWF0ZSBvdGhlciB2aWV3cG9pbnRzLgo+ID4g
PiAKPiA+ID4gVGhhbmsgeW91Lgo+ID4gCj4gPiBTb3VuZHMgbGlrZSBhIGJ1Zy4KPiA+IENhbiB5
b3UgY2hlY2sgaWYgdGhpcyBoZWxwcz8KPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGFy
Z2V0L2lzY3NpL2lzY3NpX3RhcmdldC5jCj4gPiBiL2RyaXZlcnMvdGFyZ2V0L2lzY3NpL2lzY3Np
X3RhcmdldC5jCj4gPiBpbmRleCBiNTE2YzI4OTM0MjAuLmFkNjg3MDZhZDlmNyAxMDA2NDQKPiA+
IC0tLSBhL2RyaXZlcnMvdGFyZ2V0L2lzY3NpL2lzY3NpX3RhcmdldC5jCj4gPiArKysgYi9kcml2
ZXJzL3RhcmdldC9pc2NzaS9pc2NzaV90YXJnZXQuYwo+ID4gQEAgLTEwNjAsNyArMTA2MCw4IEBA
IGludCBpc2NzaXRfc2V0dXBfc2NzaV9jbWQoc3RydWN0IGlzY3NpdF9jb25uCj4gPiAqY29ubiwg
c3RydWN0IGlzY3NpdF9jbWQgKmNtZCwKPiA+IAo+ID4gSVNDU0lfUkVBU09OX0JPT0tNQVJLX0lO
VkFMSUQsIGJ1Zik7Cj4gPiDCoMKgwqDCoMKgwqDCoCB9Cj4gPiAKPiA+IC3CoMKgwqDCoMKgwqAg
aWYgKGhkci0+b3Bjb2RlICYgSVNDU0lfT1BfSU1NRURJQVRFKSB7Cj4gPiArwqDCoMKgwqDCoMKg
IGlmICgoaGRyLT5vcGNvZGUgJiBJU0NTSV9PUF9JTU1FRElBVEUpICYmCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqAgIWNvbm4tPnNlc3MtPnNlc3Nfb3BzLT5JbW1lZGlhdGVEYXRhKSB7Cj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfZXJyKCJJbGxlZ2FsbHkgc2V0IEltbWVk
aWF0ZSBCaXQgaW4gaVNDU0kKPiA+IEluaXRpYXRvciIKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIgU2NzaSBDb21tYW5k
IFBEVS5cbiIpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBpc2Nz
aXRfYWRkX3JlamVjdF9jbWQoY21kLAo+ID4gCj4gCj4gCj4gVGhlc2UgYXJlIGRpZmZlcmVudCB0
aGluZ3MuCj4gCj4gSW1tZWRpYXRlIGRhdGEgbWVhbnMgeW91IGNhbiBoYXZlIGRhdGEgYWZ0ZXIg
dGhlIGhlYWRlciBpbiB0aGUgUERVLgo+IAo+IFRoZSBpbW1lZGlhdGUgYml0IG9uIHRoZSBoZWFk
ZXIgaGFzIENtZFNOIHJ1bGVzIHdoaWNoIGFsbG93cyB5b3UgdG8KPiBzZW5kIGNvbW1hbmRzIHdp
dGhvdXQgaGF2aW5nIHRvIGluY3JlbWVudCB0aGUgQ21kU04uIEl0J3MgdXNlZCBmb3IKPiB0aGlu
Z3MgbGlrZSBUTUZzIGJlY2F1c2UgYXQgdGhhdCB0aW1lLCB0aGUgd2luZG93IG1pZ2h0IGJlIGNs
b3NlZCBkdWUKPiB0byBTQ1NJIGNvbW1hbmRzIGhhdmluZyBmaWxsZWQgaXQuCj4gCj4gCgpJIGhh
dmUgaXNjc2kgYm9vdGVkIGZvciB5ZWFycyB3aXRoIExJTyBhcyB0aGUgdGFyZ2V0IGJ1dCBuZXZl
ciB3aXRoCnFlZGkgYXMgdGhlIGJhc2UgSVNDU0kgZHJpdmVyLiBJIHdpbGwgc2VlIGlmIEkgc2Vl
IHRoZSBzYW1lIGJlaGF2aW9yIGFzCkxlZSB3aXRoIHRoZSBxZWRpIGludm9sdmVkLgoKCgo=


