Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5616E15638D
	for <lists+target-devel@lfdr.de>; Sat,  8 Feb 2020 10:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgBHJMy (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Sat, 8 Feb 2020 04:12:54 -0500
Received: from sonic308-1.consmr.mail.bf2.yahoo.com ([74.6.130.40]:43204 "EHLO
        sonic308-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbgBHJMy (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Sat, 8 Feb 2020 04:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581153173; bh=ntCsvVlsVYNXsouoo59ZH21v1wHZ5nZJzCG4NsnkusM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=JhkrsvDCUYYRMRmnldIPYSheuSbOVlR2MF/MnPe2uwRKOAu7hKFENUCKNWRdY97JQ5Qnl0aUQr92RSj3EZMkkWr9G1Vw5TOtoiEUwkCNcye3DDvN8t8j/obdS3++IPsmRNNMPfMJDCZvUyNqqEwm7vDuQGtLKVxxkjvCFebjPJ7paOnb5e8v9j7ZFFl75luNBF39jkS9L95YiSXDx1A8ZiWbImgjPE1kkowiE0hLznzAUrkJdVXtbL+yCcTRbDzf1B2k6rxu1eUSg8Gv7KQCebwBhiL79IY3v78+SVTTOtVRk94vTjolcsXReqJXKw1AiEhozXPFUAK4oklX3PsM2w==
X-YMail-OSG: z9s8j3wVM1msONqS.ff4gQXQCiPVEFpilgJxnGCKLsha3nqF.0Db2DuOuhwDs.I
 KM3p.UuI8YmAzXIJbuR0655gkJ8SQskahsjMEC.Sc9pYkr.ZZZQzrwjBeOQkEO0dM6I5dTHn8vQL
 3c5O1A3nAvNYquFNYYh5CNTOTicy1M105wPWH9ZZNaY3K4OAtvnEpkrcmYWRLE3CsOY4DQQSNx7F
 AFRpbCvgFcJ7rPsyQAf0YFPlzhmI3Jdvu6DRcrkfuAGAooqEkbGPArbzVckdTeVnci0bfMgRWwcn
 06XY7xAR5ybSzsKbLl_yXcw2eh0gtqGZ6XRi_MlOQAzTAryg0M4DKePzoh705TEmXBJOlFFvU_7S
 wcLr5fvJ8V1cW42LWhtB_7RL7LqWkJwQXw1h90.f7ExRLReui7MxNyVvvl985b.lcpG4HfNJCSV2
 HNVQuRZdD8W3N5SACIQIRqyXcE3TjbV2eBb9AW8QSDdN4khMN9mOKSp_eL4RlmD8lgoxLsBgYKm7
 gY4OJ_riNPK5tBQohrXmpKpNh6kJ0za9aeuT0OTr2zFfQRJlPdfHAPGHVcmXa43ozw.I82Q7LGbT
 _B8y2Tl_dYI0OCVzn6PBog_7KdryzRBYGlBdKN5blFvsHvPcFc2KCGVVao7WLD69rcWFibjNNGiK
 e4vX1nH5fb.PXn7UMVnWT.ah.cTnsEfTfb1QlRC_rqOGi1wEpYyLkeH1dIw5s2wyQd2tc5OUy4Av
 konUb4rIVvH45xq7rvhhQ0RBn1Ibc9zewCaiuV..85cIxcgheuqv2eACAPnFxVRstFr3brTZc0RJ
 jewovTKmrpif0Zm_ZJ16UgGSCjGgMOXsv_2eu0WtgQBMomvdB4kb0.N.nhwz9FYxAyIs7mUQ50Lv
 8Bn8mUMG1S0UAiznv0eUT9bDhJDYTPlgkoCn5uEGSeFv6ncNTmSEjB9LAFD2kYFMPPHW1cugiSKV
 4kVhnIyraynW9_XB9a8A5TmYpU7lWEvUWNMoMoHGpFnaFpMgn.XPhXn4.MZCJol2CXxFiSYTUdM0
 6RYL2kyc8kIW6YZsr7u0vbjrzy54AjdY8apGCSPLOCdwMnE90baChWGqs.i.b11xBNwK3ax.MyR2
 LZyUatobV4.UtCxP8KrKp0IoR18ZiPRHzBTzMVv0kCMPtf4OBLuzxyq90ihgQxpJD4CP.92lri3k
 h5MXr0O6rINiABFpeME9oQCrN8Z39XsvYxWE1kt00uyjBEQKCeQkke0Io_IMidbr2BijY0esl1Qr
 8ugL1yS1xr7fPRUQzAc1Krle1Y87lqcNVIfwl06yvgsAZdn9z90n7p0tVER_zb7g69PEaqfMK83i
 f2Mw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Sat, 8 Feb 2020 09:12:53 +0000
Date:   Sat, 8 Feb 2020 09:12:49 +0000 (UTC)
From:   "Mrs. Aminatou Zainab" <jackson.jacksonn556@gmail.com>
Reply-To: miss.aminatouzainab@gmail.com
Message-ID: <1287904492.69191.1581153169570@mail.yahoo.com>
Subject: WITH DUE RESPECT YOUR ATTENTION IS VERY VERY NEEDED URGENT.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1287904492.69191.1581153169570.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org





ATTENTION: DEAR BENEFICIARY CONGRATULATIONS TO YOU,

I RECEIVE YOUR CONTENT OF YOUR EMAIL FROM FEDEX ATM CARD OFFICES YOUR FUNDS SUM OF $10.500,000, 000. MILLION DOLLARS, HAS DISCOVER HERE AFTER THE BOARD OF DIRECTORS MEETINGS, THE UNITED NATIONS GOVERNMENT HAVE DECIDED TO ISSUE YOU YOUR (ATM CARD) VALUED @ TEN MILLION FIVE HUNDRED THOUSAND DOLLARS ($) COMPENSATION FUND THROUGH THIS (ATM) CARD.

THIS IS TO BRING TO YOUR NOTICE THAT YOUR VALUED SUM OF 10.5 MILLION DOLLARS HAS BEING CREDITED IN YOUR NAME AS BENEFICIARY TO THIS (ATM CARD), AND HAS BEEN HANDLE TO THE FOREIGN REMITTANCE DEPARTMENT TO SEND IT TO YOU IN YOUR FAVOR IMMEDIATELY WITHOUT ANY DELAY,

YOU HAVE ACCESS TO MAKE DAILY WITHDRAWALS OF ($5,500) UNITED STATE DOLLARS DAILY.

WE RECEIVE YOUR INFORMATIONS AND YOUR HOME ADDRESS OF YOUR COUNTRY AND WE WILL SEND TO YOU YOUR (ATM CARD), WE HAVE ALSO RECEIVED A SIGNAL FROM THE SWISS WORLD BANK TO TRANSFER YOUR BELONGING (ATM) TO YOU WITHIN ONE WEEK, WITHOUT ANY DELAY AS WE RECORD.

WE HAVE JUST FINISHED OUR ANNUAL GENERAL MEETING WITH BANK OF AMERICA (BOA).

FOR MORE INFORMATION PLEASE GET BACK TO ME AS SOON AS POSSIBLE.

YOURS
SINCERELY.

DIRECTOR FEDEX SERVICE (USA).
MRS. AMINATOU. Z. MAKEL.
